require 'rubygems'
require 'spork'


Spork.prefork do

  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
  $LOAD_PATH.unshift(File.dirname(__FILE__))
  require 'rspec'
  require 'rr'
  #require 'choice'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rr
  end
end

Spork.each_run do
  load File.dirname(__FILE__) + "/../lib/rchoice.rb"
end