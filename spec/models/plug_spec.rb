require 'rails_helper'

RSpec.describe Plug, type: :model do
  let(:plug) { Plug.new(name: name, login_user: 'admin', login_password: '1234', hnap_url: 'http://127.0.0.1/HNAP1') }
  let(:name) { 'Test Plug' }

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

        it 'is invalid' do
          expect(plug).not_to be_valid
        end
      end
    end
  end
end
