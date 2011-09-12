require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'cleandata/dot_hash'

describe Cleandata::DotHash do

  it "is a hash" do
    subject[:foo] = "bar"
    subject[:foo].should == "bar"
  end

  it "can access elements with dots" do
    subject[:bar] = "foo"
    subject.bar.should == "foo"
  end

  it "can't access missing values" do
    lambda { subject.foo }.should raise_error(NoMethodError)
  end

  it "can't write using dots" do
    subject[:foo] = "foo"
    lambda { subject.foo = "bar" }.should raise_error(NoMethodError)
  end

  it "can convert hashes into dotabbles" do
    {:bar => "bar"}.dottable.bar.should == "bar"
  end

end