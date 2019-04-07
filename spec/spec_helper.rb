require 'webmock/rspec'
require 'dotenv'
require './lib/db/database_connection'

Dotenv.load('test.env')

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:suite) do
    Db::DatabaseConnection.instance.establish
  end

  config.after(:suite) do
    Db::DatabaseConnection.instance.close
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  include WebMock::API

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
