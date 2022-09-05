require 'tiny_tds'
require 'yaml'
require 'pathname'
require 'arel'
require 'active_support/core_ext/kernel/reporting'
require 'active_record/connection_adapters/sqlserver_adapter'
require 'arel_sqlserver'
require 'logger'
require 'ostruct'
require 'byebug'

module Database
  @connections = []
  @engines = []

  def self.connections
    @connections
  end

  def self.establish_connection(env, config)
    connection_settings = config[env.to_s].each_with_object({}) do |i,h| 
      h[i[0].to_sym] = i[1]
      h[:mode] = :dblib
      h
    end
    connection = ActiveRecord::ConnectionAdapters::SQLServerAdapter.new_client(connection_settings)
    @connections << connection
    wrapper = ActiveRecord::ConnectionAdapters::SQLServerAdapter.new(connection, Logger.new(STDOUT), nil, connection_settings)
    visitor = Arel::Visitors::SQLServer.new wrapper
    @engines << OpenStruct.new(connection: OpenStruct.new(visitor: visitor))
    nil
  end

  #def self.establish_connection(config)
  #  config.delete_if{|i| i == "default"}.each do |item|
  #    connection_settings = item.last.each_with_object({}) do |i,h| 
  #      h[i[0].to_sym] = i[1]
  #      h[:mode] = :dblib
  #      h
  #    end
  #    connection = ActiveRecord::ConnectionAdapters::SQLServerAdapter.new_client(connection_settings)
  #    @connections << connection
  #    wrapper = ActiveRecord::ConnectionAdapters::SQLServerAdapter.new(connection, Logger.new(STDOUT), nil, connection_settings)
  #    visitor = Arel::Visitors::SQLServer.new wrapper
  #    @engines << OpenStruct.new(connection: OpenStruct.new(visitor: visitor))
  #  end
  #  nil
  #end

  def self.source
    @connections.first
  end

  def self.destination
    @connections.last
  end

  def self.source_engine
    @engines.first  
  end

  def self.destination_engine
    @engines.last
  end

  def self.set_engine(engine)
    Arel::Table.engine = engine
  end

  def self.close_connection(connection)
    connection.close
    @connections.delete_if { |conn| conn.eql?(connection) }
  end

  def self.execute_query(connection, sql)
    connection.execute(sql)
  end

  def self.config
    @config = YAML.safe_load(yaml.read, aliases: true)
  end

  def self.yaml
    ::Pathname.new(File.expand_path(File.join('.', 'database.yml')))
  end
end
