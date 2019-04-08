require './lib/models/campaign'
require './lib/discrepancy_detector/callable'

module DiscrepancyDetector
  class CampaignDiscrepancyDetector
    include Callable

    # attributes to use for finding discrepancy
    DISCREPANCY_ATTRIBUTES = { status: 'status', ad_description: 'description'}.freeze

    # local_campaigns - array of campaigns fetched from database
    # remote_campaigns - array of campaigns fetched via API call
    def initialize
      @local_campaigns = Campaign.all
      @remote_campaigns = Campaign.get_remote_campaigns
      @missing_remote_campaigns = []
      @changed_campaigns = []
    end

    # method to get discrepancy between local and remote campaigns
    #
    # @return hash of changed_campaigns and missing_remote_campaigns
    # changed_campaigns - contains reference and array of changes with values if discrepancy found
    # missing_remote_campaigns - contains hash of local campaign data if a campaign not present in remote
    # else return empty hash
    def call
      result = {}

      # loop on local remotes
      @local_campaigns.each do |local_campaign|
        discrepancies = []

        # find remote campaign using external reference
        remote_campaign = remote_campaign_by_local_reference(local_campaign.external_reference)

        if remote_campaign
          DISCREPANCY_ATTRIBUTES.each do |local_attr, remote_attr|
            if local_campaign[local_attr] != remote_campaign[remote_attr]
              discrepancies << discrepancy_hash(remote_attr, remote_campaign[remote_attr], local_campaign[local_attr])
            end
          end
        else
          @missing_remote_campaigns << new_campaign_hash(local_campaign)
        end

        unless discrepancies.empty?
          @changed_campaigns << changed_campaign_hash(local_campaign.external_reference, discrepancies)
        end
      end

      result[:changed_campaigns] = @changed_campaigns unless @changed_campaigns.empty?
      result[:missing_remote_campaigns] = @missing_remote_campaigns unless @missing_remote_campaigns.empty?

      result
    end

    private

    # find the campaign in remote campaigns by external_reference value of local campaign
    def remote_campaign_by_local_reference(campaign_reference)
      @remote_campaigns.find { |remote_campaign| remote_campaign['reference'] == campaign_reference }
    end

    # prepare discrepany hash for an field
    def discrepancy_hash(key, remote_value, local_value)
      { key.to_sym => { remote: remote_value, local: local_value } }
    end

    # prepare discrepany details for an campaign
    def changed_campaign_hash(reference, discrepancies)
      {
        remote_reference: reference,
        discrepancies: discrepancies
      }
    end

    # prepare campaign detail hash if local campaign not present in remote
    def new_campaign_hash(local_campaign)
      { job_id: local_campaign.job_id, status: local_campaign.status, description: local_campaign.ad_description }
    end
  end
end