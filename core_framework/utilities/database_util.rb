require 'tiny_tds'
require 'yaml'

module Utilities
  class DatabaseUtil
    def initialize(env)
      @envHash = Hash.new
      #get the database config from ../../data/database.yml by $env
      db_config = YAML.load(File.open("#{File.dirname(__FILE__)}/../../data/database.yml"))
      @envHash[:mode]="dblib"
      @envHash[:timeout]=5000
      @envHash[:username]=db_config[env]['username']
      @envHash[:password]=db_config[env]['password']
      @envHash[:dataserver]=db_config[env]['dataserver']
      @envHash[:database]= db_config[env]['database']
    end

    def query(sql)
      Common.logger_info sql
      result = []
      client = TinyTds::Client.new(@envHash)
      client = TinyTds::Client.new(@envHash)
      client.execute('SET ANSI_NULLS ON').do
      client.execute('SET QUOTED_IDENTIFIER ON').do
      client.execute('SET CONCAT_NULL_YIELDS_NULL ON').do
      client.execute('SET ANSI_WARNINGS ON').do
      client.execute('SET ANSI_PADDING ON').do
      client
      begin
        result = client.execute(sql).to_a
        return result
      rescue => e
        Common.logger_error "error in execute_query -- #{sql} \n #{e.message}"
      end
    ensure client.close unless client.closed?
      end

    def query_return_affected_rows(sql)
      Common.logger_info sql
      result = []
      client = TinyTds::Client.new(@envHash)
      begin
        result = client.execute(sql)
        result.each
        rows = result.affected_rows
        return rows
      rescue => e
        Common.logger_error "error in execute_query -- #{db_category+sql} \n #{e.message}"
      end
    ensure client.close unless client.closed?
      end

  end
end
