require 'appengine-api-1.0-sdk-1.5.1.jar'
require 'appengine-remote-api-1.5.1.jar'
require 'cleandata/connection'

module Cleandata

  class Connector

    attr_accessor :host
    attr_accessor :port
    attr_accessor :username
    attr_accessor :password
    attr_reader :connection

    def initialize(options = {})
      @host = options[:host] || "cleancoders.appspot.com"
      @port = options[:port] || 443
      @username = options[:username] || ""
      @password = options[:password] || ""
    end

    def connect!
      installer = Java::com.google.appengine.tools.remoteapi.RemoteApiInstaller.new
      remote_options = Java::com.google.appengine.tools.remoteapi.RemoteApiOptions.new
      remote_options.server @host, @port
      remote_options.credentials @username, @password
      installer.install remote_options
      service = Java::com.google.appengine.api.datastore.DatastoreServiceFactory.getDatastoreService
      @connection = Connection.new(service)
    end

    def self.connect(options = {})
      connector = new(options)
      connector.connect!
      connector.connection
    end

  end

end