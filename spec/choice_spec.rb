require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Choice" do
  it 'smoke' do
    2.should == 2
  end
  before do
    @choice = Choice::Choice.new
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
      lambda { @choice.chosen_option }.should raise_error(Choice::OptionNotChosenError)
    end

    describe 'cl chooser' do
      before do
        chooser = Choice::CommandLineChooser.new
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
