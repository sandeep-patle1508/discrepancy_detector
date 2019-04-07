require 'active_record'
require './lib/ad_service_api/client'

class Campaign < ActiveRecord::Base

  # class method to get remote campaigns
  #
  # @return array of campaign data if API call successful
  # else return empty array 
  def self.get_remote_campaigns
    api_response = AdServiceApi::Client.new.get_campaigns
    parsed_response = JSON.parse(api_response.parsed_response)['ads']

    api_response.success? && parsed_response ? parsed_response : []
  end
end