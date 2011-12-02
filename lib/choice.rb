require 'mharris_ext'
require 'andand'

class Array
  def rand_el
    i = rand(length)
    self[i]
  end
end

module Choice
  class OptionNotChosenError < Exception; end
  class Choice
    include FromHash
    attr_accessor :optional, :action_blk, :chooser
    fattr(:options) { [] }
    fattr(:option_presenter) do
      lambda { |o| o.to_s }
    end
    fattr(:chosen_option) do
      res = chooser.call(self)
      raise OptionNotChosenError.new if !res && !optional
      res
    end
    def execute!
      return unless action_blk
      chosen_option.execute!(&action_blk) if chosen_option
    end
    def add_option(obj)
      self.options << Option.new(:base_obj => obj)
    end
  end

  class Option
    include FromHash
    attr_accessor :base_obj
    fattr(:execute_args) { [base_obj] }
    def execute!(&b)
      b.call(*execute_args)
    end
  end

  class CommandLineChooser
    def call(choice)
      print_line "Choose"
      choice.options.each_with_index do |op,i|
        print_line "#{i}. #{op.base_obj.to_s}"
      end
      get_choice(choice)
    end
    def print_line(ln)
      puts ln
    end
    def get_choice(choice)
      choice.options[get_choice_num]
    end
    def get_choice_num
      STDIN.gets.to_i
    end
  end
end