require 'thor'
require 'tmpdir'
require 'pathname'
require 'open3'

module Slate
  module Installer
    class Cli < Thor
      package_name "Slate Installer"
      include Thor::Actions

      self.add_runtime_options!

      def self.source_paths
        [Dir.tmpdir]
      end

      desc "install", "creates a docs folder and installs latest slate into it"
      method_option :logo, :type => :string, :aliases => "-l", :desc => "path to custom logo file", :lazy_default => ""
      def install
        if options[:logo]
          logo = determine_logo_path(options[:logo])
        end

        Dir.mktmpdir("slate-src-") do |tmpdir|
          output, _status = Open3.capture2e("git", "clone", "--depth", "1", "--progress", "https://github.com/lord/slate.git",  tmpdir)
          puts output

          if logo
            slate_logo_path = File.join(tmpdir, "source", "images", "logo.png")
            logo_mode = File.stat(slate_logo_path).mode
            create_file slate_logo_path, File.binread(logo), {:force => true}
            chmod slate_logo_path, logo_mode, {}
          end

          directory Pathname.new(tmpdir).basename, "docs", \
            mode: :preserve, recursive: true, exclude_pattern: /(?:\.git(?:hub)?\/)|(?:\.travis)/
        end
      end

      private

      def self.exit_on_failure?
        true
      end

      def determine_logo_path(logo)
        logo = String(logo)
        if logo.empty?
          logo = ask("Enter the path to the logo file:", :path => true)
        end

        if logo.empty?
          raise ::Thor::MalformattedArgumentError, "A logo path must be provided when using the logo option"
        end

        unless File.file?(File.expand_path(logo))
          raise ::Thor::MalformattedArgumentError, "The logo path provided is not a file"
        end

        logo
      end
    end
  end
end
