require 'mharris_ext'
require 'andand'

module RChoice
  class OptionNotChosenError < Exception; end
end

d = File.expand_path(File.dirname(__FILE__))
Dir["#{d}/rchoice/**/*.rb"].each do |f|
  require f
end