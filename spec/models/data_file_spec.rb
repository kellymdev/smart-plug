require 'rails_helper'

RSpec.describe DataFile, type: :model do
  let(:filename) { 'test.txt' }
  let!(:plug) { Plug.create!(name: 'Test Plug', login_user: 'admin', login_password: '1234', ip_address: '127.0.0.1') }
  let(:data_file) { DataFile.new(filename: filename, plug: plug) }

  describe 'validations' do
    context 'filename' do
      context 'with a filename' do
        let(:filename) { 'test.txt' }

        it 'is valid' do
          expect(data_file).to be_valid
        end
      end

      context 'without a filename' do
        let(:filename) { }

        it 'is not valid' do
          expect(data_file).not_to be_valid
        end
      end
    end
  end
end
