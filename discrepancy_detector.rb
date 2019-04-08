#!/usr/bin/env ruby
begin  
  require './lib/discrepancy_detector'
  require 'dotenv'
  require './lib/db/database_connection'
rescue LoadError => e
  abort "Could not load files #{e}"
end

# load development environment variables
Dotenv.load('development.env')

# establish database connection
# ensure to close connection at the end
begin
  Db::DatabaseConnection.instance.establish
  DiscrepancyDetector::App.new.run(ARGV)
rescue => e
  DiscrepancyDetector::PrintHelper.print_error(e)
ensure
  Db::DatabaseConnection.instance.close
end
