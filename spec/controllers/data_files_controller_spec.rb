require 'rails_helper'

RSpec.describe DataFilesController, type: :controller do
  describe '#upload' do
    let(:data_file) { fixture_file_upload('sample_data.txt', 'text/txt') }
    let!(:plug) { Plug.create!(name: 'Test Plug', login_user: 'admin', login_password: '1234', ip_address: '127.0.0.1') }

    it 'creates a data_file' do
      expect { post :upload, params: { id: plug.id, data_file: data_file } }.to change { DataFile.count }.by 1
    end

    it 'redirects to the plug details screen' do
      post :upload, params: { id: plug.id, data_file: data_file }

      expect(response).to redirect_to plug
    end
  end
end
