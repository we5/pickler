require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Pickler::Feature do
  before do
    @pickler = Pickler.new(File.dirname(__FILE__))
    @feature = Pickler::Feature.new(@pickler, "12345")
  end

  it "should determine a useful feature file name" do
    @feature.should_receive(:to_s).and_return('Feature: Fun things to do')
    @feature.feature_title.should == 'Fun things to do'
  end
  
  context "filename" do
    it "should return id if feature file doesn't exist" do
      expected = File.expand_path(File.join(File.dirname(__FILE__), "..", "features", "12345.feature"))
      @feature.should_receive(:to_s).and_return('')
      @feature.filename.should == expected
    end

    it "should return generated filename if feature file doesn't exist" do
      feature_file = File.expand_path(File.join(File.dirname(__FILE__), "..", "features", "12345.feature"))
      @feature.should_receive(:find_feature_filename).and_return(nil)
      @feature.should_receive(:to_s).twice.and_return('Feature: Fun things to do')
      feature_file = File.expand_path(File.join(File.dirname(__FILE__), "..", "features", "fun_things_to_do.feature"))
      @feature.filename.should == feature_file
    end
  end
end
