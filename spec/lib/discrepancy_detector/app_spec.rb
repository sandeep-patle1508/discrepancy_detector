require 'spec_helper'
require './lib/discrepancy_detector'

describe DiscrepancyDetector::App do

  describe '.run' do
    subject { DiscrepancyDetector::App.new.run(argv) }

    context 'when pass valid action request' do
      let(:argv) { ['campaign'] }

      it 'should not raise error' do
         expect { subject }.not_to raise_error
      end

      it "should run and initiated DiscrepancyDetector" do
        expect( subject ).to_not be false
      end
    end

    context 'when pass invalid action request' do
      let(:argv) { [] }

      it 'should raise error' do
         expect { subject }.to raise_error('We do not support this action, please enter a valid action.')
      end
    end
  end
end