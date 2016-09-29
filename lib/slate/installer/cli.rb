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
      def install
        Dir.mktmpdir("slate-src-") do |tmpdir|
          output, _status = Open3.capture2e("git", "clone", "--depth", "1", "--progress", "https://github.com/lord/slate.git",  tmpdir)
          puts output
          directory Pathname.new(tmpdir).basename, "docs", \
            mode: :preserve, recursive: true, exclude_pattern: /(?:\.git(?:hub)?\/)|(?:\.travis)/
        end
      end
    end
  end
end
