require 'spec_helper'
require './lib/discrepancy_detector/campaign_discrepancy_detector'

describe DiscrepancyDetector::CampaignDiscrepancyDetector do

  describe '.call' do

    subject { DiscrepancyDetector::CampaignDiscrepancyDetector.call }

    context 'when no discrepancy between local and remote' do
      before(:each) do
        stub_request(:get, 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df').with(
          headers: {
            'Accept'=>'*/*',
            'User-Agent'=>'Ruby'
          }
        ).to_return(
          status: 200,
          body: File.read('./spec/campaigns_response_without_discrepancy.json')
        )
     end

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should return empty response' do
        expect(subject).to be_empty
      end
    end

    context 'when discrepancy present between local and remote' do
      before(:each) do
        stub_request(:get, 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df').with(
          headers: {
            'Accept'=>'*/*',
            'User-Agent'=>'Ruby'
          }
        ).to_return(
          status: 200,
          body: File.read('./spec/campaigns_response_with_discrepancy.json')
        )
      end
      
      context 'when existing record changed' do
        let(:expected_result) do
          [
            {
              'remote_reference': '1',
              'discrepancies': [
                {
                  'status': {
                    'remote': 'enabled',
                    'local': 'disabled'
                  }
                },
                {
                  'description': {
                    'remote': 'Description for campaign 11',
                    'local': 'New Description for campaign 11'
                  }
                }
              ]
            },
            {
              'remote_reference': '3',
              'discrepancies': [
                {
                  'description': {
                    'remote': 'Description for campaign 13',
                    'local': 'New Description for campaign 13'
                  }
                }
              ]
            }
          ]
        end

        it 'should not raise error' do
          expect { subject }.not_to raise_error
        end

        it 'should return contains discrepancies of changed_campaigns' do
          expect(subject[:changed_campaigns].to_s).to eq(expected_result.to_s)
        end
      end
      
      context 'when new record found in local' do
        let(:expected_result) do
          [
            {
              job_id: 104,
              status: 'enabled',
              description: 'Description for campaign 14'
            }
          ]
        end

        it 'should not raise error' do
          expect { subject }.not_to raise_error
        end

        it 'should return contains missing_remote_campaigns' do
          expect(subject[:missing_remote_campaigns]).to eq(expected_result)
        end
      end
    end
  end
end