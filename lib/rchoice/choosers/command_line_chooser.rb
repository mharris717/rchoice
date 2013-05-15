module RChoice
  class CommandLineChooser
    def call(choice)
      print_line "Choose #{choice.name}"
      choice.options.each_with_index do |op,i|
        print_line "#{i}. #{choice.option_presenter[op]}"
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
      STDIN.gets.safe_to_i
    end
  end
end