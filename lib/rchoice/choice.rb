module RChoice
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
    def make_option(obj,&b)
      return obj if obj.kind_of?(Option)
      obj = {:base_obj => obj} unless obj.kind_of?(Hash)
      Option.new(obj)
    end
    def add_option(obj,&b)
      self.options << make_option(obj,&b)
    end
    def options=(raw)
      @options = raw.map { |r| make_option(r) }
    end
  end

  class ProcChoice < Choice
    def execute!
      chosen_option.execute! if chosen_option
    end
    def make_option(name,&b)
      ProcOption.new(:name => name, :blk => b)
    end
  end
end