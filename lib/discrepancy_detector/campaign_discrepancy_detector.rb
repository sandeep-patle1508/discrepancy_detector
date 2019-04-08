require './lib/models/campaign'
require './lib/discrepancy_detector/callable'

module DiscrepancyDetector
  class CampaignDiscrepancyDetector
    include Callable

    DISCREPANCY_ATTRIBUTES = { status: 'status', ad_description: 'description'}.freeze

    def initialize
      @local_campaigns = Campaign.all
      @remote_campaigns = Campaign.get_remote_campaigns
      @missing_remote_campaigns = []
      @changed_campaigns = []
    end

    def call
      result = {}

      @local_campaigns.each do |local_campaign|
        discrepancies = []
        remote_campaign = remote_campaign_by_local_reference(local_campaign.external_reference)

      end

      result
    end

    private

    def remote_campaign_by_local_reference(campaign_reference)
      @remote_campaigns.find { |remote_campaign| remote_campaign['reference'] == campaign_reference }
    end
  end
end