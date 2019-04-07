require 'dotenv'
require './lib/db/database_setup'

Dotenv.load('test.env')

class TestDatabaseSetup < DatabaseSetup

  private

  # initial data for test environment
  #
  # @return nested array with values in sequence of 
  # [<job_id>, <status>, <external_reference>, <ad_description>]
  def campaigns_records
    [
      [101, 'disabled', '1', 'New Description for campaign 11'],
      [102, 'disabled', '2', 'Description for campaign 12'],
      [103, 'enabled', '3', 'New Description for campaign 13'],
      [104, 'enabled', '4', 'Description for campaign 14']
    ]
  end
end

Db::TestDatabaseSetup.new.setup
