require 'spec_helper'
require './lib/ad_service_api/client'

describe AdServiceApi::Client do

  describe '.get_campaigns' do

    # mock the campaigns API response
    before(:each) do
      stub_request(:get, 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df').with(
        headers: {
          'Accept'=>'*/*',
          'User-Agent'=>'Ruby'
        }
      ).to_return(
        headers: { 'Content-Type': 'application/json' },
        status: 200,
        body: File.read('./spec/campaigns_response_with_discrepancy.json')
      )
    end

    subject { AdServiceApi::Client.new.get_campaigns }

    context 'when return valid response' do
      it 'should return array of ads data' do
        expect(subject.parsed_response['ads']).to be_an_instance_of(Array)
      end

      it 'should return success response' do
        expect(subject.success?).to be_truthy
      end

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end
    end
  end
end