class PerformHnapLogin
  attr_reader :plug, :hnap_login

  def initialize(plug)
    @plug = plug
    @hnap_login = plug.hnap_logins.new
  end

  def call
    response = HTTParty.post(plug_url, headers: login_headers, body: login_body)

    parse_xml(response.body)
  end

  private

  def plug_url
    "http://#{plug.id}/HNAP1"
  end

  def login_headers
    {
      'Content-Type' => 'text/xml; charset=utf-8',
      'SOAPAction' => 'http://purenetworks.com/HNAP1/Login'
    }
  end

  def login_body
    <<-XML
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope "xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Login xmlns="http://purenetworks.com/HNAP1/">
      <Action>request</Action>
      <Username>#{plug.login_user}</Username>
      <LoginPassword></LoginPassword>
      <Captcha></Captcha>
    </Login>
  </soap:Body>
</soap:Envelope>
    XML
  end

  def parse_xml(response)
    doc = Nokogiri::XML(response)

    login_result = doc.xpath('//LoginResult')
    challenge = doc.xpath('//Challenge')
    public_key = doc.xpath('//PublicKey')
    cookie = doc.xpath('//Cookie')

    hnap_login.update!(
      login_result: login_result,
      challenge: challenge,
      public_key: public_key,
      cookie: cookie
    )
  end

  def private_key
    "#{hnap_login.public_key} #{plug.login_password} #{hnap_login.challenge}".upcase
  end
end
