require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'cleandata/connection'
require 'cleandata/connector'
require 'cleandata/dot_hash'

describe Cleandata::Connection do

  context "with real connection" do

    before(:all) do
      @connection = Cleandata::Connector.connect(:host => "localhost", :port => 8080)
    end

    it "converts an entity to a dot hash" do
      jentity = Java::com.google.appengine.api.datastore.Entity.new("Widget", 1234)
      jentity.setProperty("foo", "FOO!!!")
      jentity.setProperty("bar", 1234)

      entity = @connection.unpack_entity(jentity)

      entity.kind.should == "Widget"
      entity.key.should == @connection.key_to_s(jentity.getKey())
      entity.foo.should == "FOO!!!"
      entity.bar.should == 1234
    end

    context "finding codecasts" do

      before(:all) do
        @codecasts = @connection.find_by_kind("codecast")
      end

      it "gets results" do
        @codecasts.size.should > 10
      end

      it "all are dot hashed" do
        @codecasts.each do |e|
          e.class.should == Cleandata::DotHash
        end
      end
    end

    context "finding viewings" do

      it "get all" do
        viewings = @connection.find_by_kind("viewing")
        viewings.size.should > 10000
      end

      it "gets 10" do
        viewings = @connection.find_by_kind("viewing", :limit => 10)
        viewings.size.should == 10
        viewings.each do |v|
          v.class.should == Cleandata::DotHash
        end
      end

      it "with filter" do
        viewings = @connection.find_by_kind("viewing", :filters => [[:ip_address, :eq, "67.184.199.69"]])
        viewings.size.should > 20
        viewings.size.should < 100
      end

      it "sorts" do
        viewings = @connection.find_by_kind("viewing", :sorts => [[:created_at, :asc]], :limit => 10)
        viewings.each {|v| p v}
        9.times do |i|
          viewings[i].created_at.before(viewings[i+1].created_at).should == true
        end
      end

    end




  end

end