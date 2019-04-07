require 'spec_helper'
require './lib/discrepancy_detector'

describe DiscrepancyDetector::App do

    subject { DiscrepancyDetector::App.new.run }

    context 'when pass valid action name' do
      it 'should not raise error' do
         expect { subject }.not_to raise_error
      end

      it "should run and initiated DiscrepancyDetector" do
        expect( subject ).to_not be false
      end
    end

    context 'when pass invalid action name' do
      it 'should raise error' do
         expect { subject }.to raise_error('We do not support this action, please enter a valid action.')
      end
    end
  end
end