module RChoice
  class Option
    include FromHash
    attr_accessor :base_obj
    fattr(:execute_args) { [base_obj] }
    def execute!(&b)
      b.call(*execute_args)
    end
    def to_s
      base_obj.to_s
    end
  end

  class ProcOption < Option
    include FromHash
    attr_accessor :name, :blk
    def execute!
      blk.call
    end
    def to_s
      name
    end
  end
end