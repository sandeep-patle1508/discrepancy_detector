require 'active_record'
require './lib/db/database_connection'

module Db
  class DatabaseSetup

    # establish database connection as per current environment
    def initialize
      @connection = Db::DatabaseConnection.instance
      @connection.establish
    end

    # create campaigns table if not already exist
    # insert initial set of data
    def setup
      begin
        create_campaign_table_if_not_exist
        seed_data
      rescue Exception => e
        raise "Database setup failed with error #{e}"
      ensure
        @connection.close
      end
    end

    private

    attr_accessor :connection

    # create campaigns table
    def create_campaign_table_if_not_exist
      sql = %{
        CREATE TABLE IF NOT EXISTS campaigns (
          id SERIAL,  
          job_id INTEGER NOT NULL,  
          status VARCHAR(255),
          external_reference VARCHAR(255),
          ad_description TEXT,
          created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
          updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
          PRIMARY KEY (id)
        )
      }
      @connection.execute(sql)
    end

    # insert data into campaign table
    def seed_data
      delete_existing_records = 'DELETE FROM campaigns'
      @connection.execute(delete_existing_records)
      
      campaigns_records.each do |record|
        sql = %{
          INSERT INTO 
            campaigns(job_id, status, external_reference, ad_description)
            VALUES(#{record[0]}, '#{record[1]}', '#{record[2]}', '#{record[3]}')
        }

        @connection.execute(sql)
      end
    end
  end
end