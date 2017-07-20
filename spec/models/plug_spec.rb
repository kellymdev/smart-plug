require 'rails_helper'

RSpec.describe Plug, type: :model do
  let(:plug) { Plug.new(name: name, login_user: 'admin', login_password: '1234', ip_address: ip_address) }
  let(:name) { 'Test Plug' }
  let(:ip_address) { '127.0.0.1' }

  describe 'validations' do
    context 'name' do
      context 'with the name populated' do
        let(:name) { 'Test' }

        it 'is valid' do
          expect(plug).to be_valid
        end
      end

      context 'without a name' do
        let(:name) { '' }

        it 'is not valid' do
          expect(plug).not_to be_valid
        end
      end
    end

    context 'ip_address' do
      context 'with a valid ip address' do
        let(:ip_address) { '127.0.0.1' }

        it 'is valid' do
          expect(plug).to be_valid
        end
      end

      context 'with an invalid ip address' do
        let(:ip_address) { '127.0' }

        it 'is not valid' do
          expect(plug).not_to be_valid
        end
      end
    end
  end
end
