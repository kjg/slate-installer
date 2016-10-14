# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slate/installer/version'

Gem::Specification.new do |spec|
  spec.name          = "slate-installer"
  spec.version       = Slate::Installer::VERSION
  spec.authors       = ["Kevin Glowacz"]
  spec.email         = ["kevin@glowacz.info"]

  spec.summary       = "Easily add slate powered docs to your app"
  spec.description   = "This provides a utility to add and update your docs " \
                       "folder with the latest slate source"
  spec.homepage      = "https://github.com/kjg/slate-installer"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.0.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '~> 0.19'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
