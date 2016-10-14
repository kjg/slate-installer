require 'spec_helper'
require 'tmpdir'
require 'slate/installer/cli'

describe Slate::Installer::Cli do
  describe "#install" do
    let(:output) { capture(:stdout) { subject.install } }

    it "clones slate into a temp dir" do
      expect(output).to match(/^Cloning into \'#{Dir.tmpdir}\/slate-src-.*\'\.\.\.$/)
    end

    it "moves slate into the docs dir" do
      output
      expect(Dir.glob("docs/**/*")).to include "docs/source/fonts/slate.ttf"
    end

    it "does not move the .git files into the docs dir" do
      output
      expect(Dir.glob("docs/**/*")).not_to include "docs/.git"
      expect(Dir.glob("docs/**/*")).not_to include "docs/.github"
      expect(Dir.glob("docs/**/*")).not_to include "docs/.travis.yml"
    end

    it "makes deploy.sh executable" do
      output
      deploys_sh = File.new("docs/deploy.sh")
      expect(deploys_sh.stat).to be_executable
    end

    context "when no logo option" do
      it "keeps the original logo" do
        output
        expect(FileUtils).not_to be_identical(File.expand_path("../../../fixtures/MyLogo.png", __FILE__), "docs/source/images/logo.png")
      end
    end

    context "when specifying the logo option" do
      context "when blank" do
        subject { Slate::Installer::Cli.new([], {:logo => ""}) }

        it "asks for a path" do
          expect(subject).to receive(:ask).with("Enter the path to the logo file:", :path => true).and_return ""
          begin
            subject.install
          rescue Thor::MalformattedArgumentError
          end
        end

        context "and user input is also blank" do
          it "raises an error" do
            allow(subject).to receive(:ask).with("Enter the path to the logo file:", :path => true).and_return ""
            expect {subject.install}.to raise_error(Thor::MalformattedArgumentError, "A logo path must be provided when using the logo option")
          end
        end
      end

      context "when a directory" do
        subject { Slate::Installer::Cli.new([], {:logo => File.expand_path("..", __FILE__)}) }

        it "raises an error" do
          allow(subject).to receive(:ask).with("Enter the path to the logo file:", :path => true).and_return ""
          expect {subject.install}.to raise_error(Thor::MalformattedArgumentError, "The logo path provided is not a file")
        end
      end

      context "when not a file" do
        subject { Slate::Installer::Cli.new([], {:logo => File.expand_path("../not_a_file.txt", __FILE__)}) }

        it "raises an error" do
          allow(subject).to receive(:ask).with("Enter the path to the logo file:", :path => true).and_return ""
          expect {subject.install}.to raise_error(Thor::MalformattedArgumentError, "The logo path provided is not a file")
        end
      end

      context "when a valid file" do
        subject { Slate::Installer::Cli.new([], {:logo => File.expand_path("../../../fixtures/MyLogo.png", __FILE__)}) }
        let(:output) { capture(:stdout) { subject.install } }

        it "installs into the docs dir" do
          output
          expect(FileUtils).to be_identical(File.expand_path("../../../fixtures/MyLogo.png", __FILE__), "docs/source/images/logo.png")
        end
      end
    end
  end
end
