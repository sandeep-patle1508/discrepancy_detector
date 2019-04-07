require 'spec_helper'

describe Campaign do

  describe '#get_remote_campaigns' do

    # mock the campaigns API response
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

    subject { Campaign.get_remote_campaigns }

    context 'when remote has valid data' do

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should return array' do
        expect(subject).to be_an_instance_of(Array)
      end

      
    end
  end
end