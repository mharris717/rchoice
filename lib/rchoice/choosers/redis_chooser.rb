module RChoice
  class RedisChooser
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
      choice.options[get_choice_num(choice)]
    end
    def get_choice_num(choice)
      require 'redis'
      redis = Redis.new(:host => "spadefish.redistogo.com", :port => 9897, :password => "511c6d49855d3551c335781860c06cb3")
      k = "choice-#{choice.choice_id}"
      puts "waiting for #{k}"
      File.create "vol/choice.txt",k
      (0...10000).each do |i|
        val = redis.get(k)
        if val.present?
          return val.safe_to_i
        else
          sleep(0.5)
        end
      end
      raise "no answer"
    end
  end
end