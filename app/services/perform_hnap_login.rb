class PerformHnapLogin
  attr_reader :plug, :hnap_login

  BASE_URL = 'http://purenetworks.com/HNAP1/'
  LOGIN_URL = "#{base_url}Login"
  LOGIN_RESULT_URL = "#{base_url}LoginResult"

  def initialize(plug)
    @plug = plug
    @hnap_login = plug.hnap_logins.new
  end

  def call
    response = initial_request

    parse_xml(response.body)

    perform_login
  end

  private

  def plug_url
    "http://#{plug.id}/HNAP1"
  end

  def login_headers
    {
      'Content-Type' => 'text/xml; charset=utf-8',
      'SOAPAction' => LOGIN_URL
    }
  end

  def login_body
    <<-XML
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope "xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Login xmlns=#{BASE_URL}>
      <Action>request</Action>
      <Username>#{plug.login_user}</Username>
      <LoginPassword></LoginPassword>
      <Captcha></Captcha>
    </Login>
  </soap:Body>
</soap:Envelope>
    XML
  end

  def initial_request
    HTTParty.post(plug_url, headers: login_headers, body: login_body)
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

  def perform_login
    HTTParty.post(plug_url, headers: login_result_headers, body: login_result_body)
  end

  def login_result_headers
    {
      'Content-Type' => 'text/xml; charset=utf-8',
      'SOAPAction' => LOGIN_RESULT_URL,
      'HNAP_AUTH' => hnap_auth,
      'Cookie' => "uid=#{hnap_login.cookie}"
    }
  end

  def hnap_auth
    time_stamp = Time.now
    auth = "#{hnap_login.private_key}#{time_stamp}#{LOGIN_RESULT_URL}" # TODO: HMAC_MD5 this

    "#{auth.upcase} #{time_stamp}"
  end

  def login_result_body
    password = "#{hnap_login.private_key}#{hnap_login.challenge}" # TODO: HMAC_MD5 this

    <<-XML
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope "xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <LoginResult xmlns=#{BASE_URL}>
      <Action>login</Action>
      <Username>#{plug.login_user}</Username>"
      <LoginPassword>#{password.upcase}</LoginPassword>
      <Captcha></Captcha>
    </LoginResult>
  </soap:Body>
</soap:Envelope>
    XML
  end
end
