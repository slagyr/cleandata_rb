require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'cleandata/connector'

describe Cleandata::Connector do

  it "can connect to a local serverl" do
    subject.host = "localhost"
    subject.port = 8080
    subject.username = ""
    subject.password = ""

    subject.connect!

    subject.connection.should_not == nil
    subject.connection.class.should == Cleandata::Connection
  end

  it "defaults to cleancoders production" do
    subject.host.should == "cleancoders.appspot.com"
    subject.port.should == 443
  end

end