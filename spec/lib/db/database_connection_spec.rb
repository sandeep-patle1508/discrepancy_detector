require 'spec_helper'

describe Db::DatabaseConnection do
  describe '.establish' do
    subject { Db::DatabaseConnection.instance.establish }

    context 'when correct database confir defined' do
      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should return connected true after the connection call' do
        ActiveRecord::Base.connection
        expect(ActiveRecord::Base.connected?).to be_truthy
      end
    end
  end
end