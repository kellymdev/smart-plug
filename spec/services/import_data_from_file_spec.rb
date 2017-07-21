require 'rails_helper'

RSpec.describe ImportDataFromFile, type: :service do
  let(:plug) { Plug.create!(name: 'Test Plug', login_user: 'admin', login_password: '1234', ip_address: '127.0.0.1') }
  let(:filename) { 'test.txt' }
  let(:service) { ImportDataFromFile.new(plug, filename) }

  describe '#call' do
    before do
      allow(File).to receive(:readlines).and_return(['5/19/2017, 3:04:50 AM;11;40'])
    end

    context 'when a reading already exists for the date and time' do
      let!(:reading) do
        plug.readings.create!(
          date_time: DateTime.parse('19/5/2017 03:04:50'),
          consumption: 12,
          temperature: 39
        )
      end

      it 'does not create a new reading' do
        expect { service.call }.to change { Reading.count }.by 0
      end

      it 'updates the consumption and temperature values of the existing reading' do
        service.call

        expect(reading.reload.consumption).to eq 11
        expect(reading.reload.temperature).to eq 40
      end
    end

    context 'when a reading does not already exist for the date and time' do
      it 'creates a reading for each line in the file' do
        expect { service.call }.to change { Reading.count }.by 1
      end
    end
  end
end