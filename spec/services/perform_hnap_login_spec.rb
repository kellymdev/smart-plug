require 'rails_helper'

RSpec.describe PerformHnapLogin, type: :service do
  describe '#call' do
    let(:plug) do
      Plug.create!(
        name: 'Test Plug',
        login_user: 'admin',
        login_password: '1234',
        ip_address: '127.0.0.1'
      )
    end

    let(:plug_url) { "http://127.0.0.1/HNAP1" }

    let(:response_body) do
      <<-XML
<LoginResult>success</LoginResult>
<Challenge>super</Challenge>
<PublicKey>test123</PublicKey>
<Cookie>tasty</Cookie>
      XML
    end

    it 'creates a new hnap_login' do
      stub_request(:post, plug_url).to_return(body: response_body, status: 200)

      expect { PerformHnapLogin.new(plug).call }.to change { HnapLogin.count }.by 1
    end

    it 'sets the hnap_login credentials to the values returned in the request' do
      stub_request(:post, plug_url).to_return(body: response_body, status: 200)

      PerformHnapLogin.new(plug).call
      hnap_login = HnapLogin.last

      expect(hnap_login.login_result).to eq "success"
      expect(hnap_login.challenge).to eq "super"
      expect(hnap_login.public_key).to eq "test123"
      expect(hnap_login.cookie).to eq "tasty"
    end
  end
end
