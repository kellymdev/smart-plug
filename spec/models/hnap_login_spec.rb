require 'rails_helper'

RSpec.describe HnapLogin, type: :model do
  let(:plug) do
    Plug.create!(
      name: 'Test Plug',
      login_user: 'admin',
      login_password: '1234',
      ip_address: '127.0.0.1'
    )
  end

  let(:hnap_login) do
    plug.hnap_logins.create!(
      login_result: 'success',
      challenge: 'test',
      public_key: 'test123',
      cookie: 'hello'
    )
  end

  describe '#private_key' do
    it 'returns a uppercase private key' do
      expect(hnap_login.private_key).to eq 'TEST1231234TEST'
    end
  end
end
