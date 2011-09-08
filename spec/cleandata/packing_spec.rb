require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'cleandata/packing'

describe "Packing" do

  it "unpacks numbers" do
    1.unpack.should == 1
    -2.unpack.should == -2
    3.14.unpack.should == 3.14
  end

  it "unpacks strings" do
    "hi".unpack.should == "hi"
  end

  it "unpacks nil" do
    nil.unpack.should == nil
  end

  it "unpacks booleans" do
    true.unpack.should == true
    false.unpack.should == false
  end

  it "unpacks dates" do
    result = Java::java.util.Date.new(101, 1, 2, 3, 4, 5).unpack
    result.to_s.should == "2001-01-02T03:04:05+00:00"
  end

  it "unpacks Text" do
    text = Java::com.google.appengine.api.datastore.Text.new("blah")
    text.unpack.should == "blah"
  end

  it "unpacks Email" do
    email = Java::com.google.appengine.api.datastore.Email.new("joe@blow.com")
    email.unpack.should == "joe@blow.com"
  end

end