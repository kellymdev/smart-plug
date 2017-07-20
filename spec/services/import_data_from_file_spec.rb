require 'rails_helper'

RSpec.describe ImportDataFromFile, type: :service do
  let(:plug) { Plug.create!(name: 'Test Plug', login_user: 'admin', login_password: '1234', ip_address: '127.0.0.1') }
  let(:filename) { 'test.txt' }
  let(:service) { ImportDataFromFile.new(plug, filename) }

  describe '#call' do
    before do
      allow(File).to receive(:readlines).and_return(['5/19/2017, 3:04:50 PM;11;40'])
    end

    it 'creates a reading for each line in the file' do
      expect { service.call }.to change { Reading.count }.by 1
    end
  end
end