require 'active_record'
require 'singleton'
require 'pg'

module Db
  class DatabaseConnection
    include Singleton

    # establish database connection as per running ENV
    def establish
      ActiveRecord::Base.establish_connection(
        adapter: ENV['adapter'],
        database: ENV['database'],
        username: ENV['username'],
        password: ENV['password'],
        host: ENV['host'],
        pool: 5,
        timeout: 5000,
        port: ENV['port'] || 5432
      )
    end

    # close open database connection
    def close
      ActiveRecord::Base.connection.close
    end

    # instance method to get execute sql
    #
    # @params sql[String] Postgres SQL query
    # @return PG::Result object
    def execute(sql)
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end