require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'ProcChoice' do
  before do
    @results = []
    @choice = RChoice::ProcChoice.new
    @choice.add_option(:a) { @results << :a }
    @choice.add_option(:b) { @results << :b }
  end
  describe 'choosing first' do
    before do
      @choice.chooser = lambda { |c| c.options.first }
    end
    it 'should execute first action' do
      @choice.execute!
      @results.should == [:a]
    end
  end
end

describe 'loading options' do
  before do
    @choice = RChoice::Choice.new(:options => [3,7])
  end
  it 'should load options' do
    @choice.options.first.class.should == RChoice::Option
  end
end

describe 'redis' do
  let(:choice) do
    res = RChoice::Choice.new(:options => [3,7])
    res.chooser = RChoice::RedisChooser.new
    res
  end
  it 'should load options' do
    choice.options.first.class.should == RChoice::Option
  end
  it 'gets answer' do
    puts choice.chosen_option.inspect
  end
end

describe "Choice" do
  before do
    @choice = RChoice::Choice.new
    @choice.add_option 3
    @choice.add_option 7
  end

  describe 'choosing first' do
    before do
      @choice.chooser = lambda { |c| c.options.first }
    end
    it 'should choose first' do
      @choice.chosen_option.base_obj.should == 3
    end
  end

  describe 'choosing none' do
    before do
      @choice.chooser = lambda { |c| nil }
    end
    it 'should allow no choice if optional is true' do
      @choice.optional = true
      @choice.chosen_option.should be_nil
    end
    it 'should error if optional is false' do
      lambda { @choice.chosen_option }.should raise_error(RChoice::OptionNotChosenError)
    end

    describe 'cl chooser' do
      before do
        chooser = RChoice::CommandLineChooser.new
        stub(chooser).get_choice_num { 1 }
        stub(chooser).print_line(anything) { }
        @choice.chooser = chooser
      end
      it 'should choose first' do
        @choice.chosen_option.base_obj.should == 7
      end
    end
  end

  describe 'executing' do
    before do
      @results = []
      @choice.action_blk = lambda { |op| @results << op }
      @choice.chooser = lambda { |c| c.options.first }
    end
    it 'should call action' do
      @choice.execute!
      @results.should == [3]
    end
  end
end

describe 'core' do
  it 'should parse 0' do
    '0'.safe_to_i.should == 0
    ' 0 '.safe_to_i.should == 0
  end
  it 'should parse 1' do
    '1'.safe_to_i.should == 1
    ' 1 '.safe_to_i.should == 1
  end
  it 'should parse -1' do
    '-1'.safe_to_i.should == -1
    ' -1 '.safe_to_i.should == -1
  end
  it 'should not parse blank' do
    lambda { ''.safe_to_i }.should raise_error
    lambda { '   '.safe_to_i }.should raise_error
  end
  it 'should not parse junk' do
    lambda { ' ab'.safe_to_i }.should raise_error
    lambda { 'a4'.safe_to_i }.should raise_error
  end
  it 'should parse -1.5' do
    '-1.5'.safe_to_i.should == -1
    ' -1.5 '.safe_to_i.should == -1
  end
end