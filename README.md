# Slate::Installer

[![Build Status](https://travis-ci.org/kjg/slate-installer.svg?branch=master)](https://travis-ci.org/kjg/slate-installer)

Slate::Installer is a utility to install (or update) [Slate](https://github.com/lord/slate) into the docs folder of your project. You then can then add and modify the slate docs right within the same repo as the code it is documenting.

Running the installer on an existing slate installation will pull down the latest slate source and allow you to pick and choose which files to replace so you easily get updates without clobbering your modifications.

## Installation

Add this line to your application's Gemfile:

```ruby
  gem 'slate-installer'
```

And then execute:

```shell
  $ bundle
```

Or install it yourself as:

```shell
  $ gem install slate-installer
```

## Usage

Slate::Installer is powered by Thor, so you can run

```shell
$ slate-installer

Slate Installer commands:
  slate-installer help [COMMAND]  # Describe available commands or one specific command
  slate-installer install         # creates a docs folder and installs latest slate into it

Runtime options:
  -f, [--force]                    # Overwrite files that already exist
  -p, [--pretend], [--no-pretend]  # Run but do not make any changes
  -q, [--quiet], [--no-quiet]      # Suppress status output
  -s, [--skip], [--no-skip]        # Skip files that already exist
```

to see all the available options.

To install slate into your docs folder run

```shell
  $ slate-installer install
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kjg/slate-installer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
