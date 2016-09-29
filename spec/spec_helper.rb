$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'slate/installer'

RSpec.configure do |config|
  config.before(:each) do
    $0 = "slate-installer"                     # Pretend we're running as 'slate-installer'
    ARGV.clear                                 # Make sure no args are passed to the commands.
    @directory = Dir.mktmpdir('slate-installer-spec-') # Create a temp directory to work in.
    @orig_directory = Dir.pwd                  # Save the original directory.
    Dir.chdir(@directory)                      # Change to it.
  end

  config.after(:each) do
    Dir.chdir(@orig_directory)                 # Change back to the origin directory.
    FileUtils.remove_entry(@directory)         # Remove the temp directory.
  end
end

# Captures the output for analysis later
#
# @example Capture `$stderr`
#
#     output = capture(:stderr) { $stderr.puts "this is captured" }
#
# @param [Symbol] stream `:stdout` or `:stderr`
# @yield The block to capture stdout/stderr for.
# @return [String] The contents of $stdout or $stderr
def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end
