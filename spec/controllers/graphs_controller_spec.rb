require 'rails_helper'

RSpec.describe GraphsController, type: :controller do
  let!(:plug) { Plug.create!(name: 'Test Plug', login_user: 'admin', login_password: '1234', ip_address: '127.0.0.1') }

  let!(:reading) do
    plug.readings.create!(
      date_time: DateTime.parse('19/5/2017 03:04:50'),
      consumption: 11,
      temperature: 40
    )
  end

  describe '#consumption_data' do
    let(:expected_result) do
      [{
        date_time: reading.date_time,
        consumption: reading.consumption
      }]
    end

    it 'renders consumption over time as json' do
      get :consumption_data, params: { plug_id: plug.id, format: :json }

      expect(response.body).to eq(expected_result.to_json)
    end
  end

  describe '#temperature_data' do
    let(:expected_result) do
      [{
        date_time: reading.date_time,
        temperature: reading.temperature
      }]
    end

    it 'renders temperature over time as json' do
      get :temperature_data, params: { plug_id: plug.id, format: :json }

      expect(response.body).to eq(expected_result.to_json)
    end
  end
end
