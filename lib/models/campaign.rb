require 'active_record'

class Campaign < ActiveRecord::Base

  # class method to get remote campaigns
  #
  # @return array of campaign data if API call successful
  # else return empty array 
  def self.get_remote_campaigns
  end
end