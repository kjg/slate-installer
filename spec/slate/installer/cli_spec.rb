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
  end
end
