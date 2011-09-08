require 'cleandata/connector'

module Cleandata

  class Client

    attr_reader :connector
    attr_writer :connection

    def initialize(options = {})
      @connector = Connector.new(options)
    end

    def connection
      if @connection.nil?
        @connector.connect!
        @connection = @connector.connection
      end
      @connection
    end

    def viewers
      @connection.find_by_kind("viewer", :sorts => [[:created_at, :asc]])
    end

    def viewings
      @connection.find_by_kind("viewing", :sorts => [[:created_at, :asc]])
    end

    def codecasts
      @connection.find_by_kind("codecast", :sorts => [[:created_at, :asc]])
    end

    def licenses
      @connection.find_by_kind("license", :sorts => [[:created_at, :asc]], :filters => [[:state, :eq, "active"]])
    end

    def downloads
      @connection.find_by_kind("download", :sorts => [[:created_at, :asc]])
    end

    def payments
      @connection.find_by_kind("payment", :sorts => [[:created_at, :asc]])
    end

  end

end