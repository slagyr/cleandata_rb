require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'cleandata/client'

describe Cleandata::Client do

  it "creates a connector on initialize but doesn't connect'" do
    client = Cleandata::Client.new(:host => "localhost", :port => 8080)
    client.connector.host.should == "localhost"
    client.connector.port.should == 8080
    client.instance_variable_get("@connection").should == nil
  end

  it "allows the setting of a connection which it then uses" do
    client = Cleandata::Client.new(:host => "localhost", :port => 8080)
    connection = mock("connection")

    client.connection = connection

    client.connection.should == connection
  end

  context "with mocked connection" do

    before do
      @connection = mock("connection")
      @client = Cleandata::Client.new(:host => "localhost", :port => 8080)
      @client.connection = @connection
    end

    it "gets the viewers" do
      @connection.should_receive(:find_by_kind).with("viewer", :sorts => [[:created_at, :asc]])

      @client.viewers
    end

    it "gets the viewings" do
      @connection.should_receive(:find_by_kind).with("viewing", :sorts => [[:created_at, :asc]])

      @client.viewings
    end

    it "gets the downloads" do
      @connection.should_receive(:find_by_kind).with("download", :sorts => [[:created_at, :asc]])

      @client.downloads
    end

    it "gets the codecasts" do
      @connection.should_receive(:find_by_kind).with("codecast", :sorts => [[:created_at, :asc]])

      @client.codecasts
    end

    it "gets the licenses" do
      @connection.should_receive(:find_by_kind).with("license", :sorts => [[:created_at, :asc]], :filters => [[:state, :eq, "active"]])

      @client.licenses
    end

    it "gets payments" do
      @connection.should_receive(:find_by_kind).with("payment", :sorts => [[:created_at, :asc]])

      @client.payments
    end
  end

end