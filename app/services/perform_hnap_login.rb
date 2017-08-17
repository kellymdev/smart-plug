class PerformHnapLogin
  attr_reader :plug

  def initialize(plug)
    @plug = plug
  end

  def call
    response = HTTParty.post(plug_url, headers: login_headers, body: login_body)

    parsed_xml = parse_xml(response.body)
  end

  private

  def plug_url
    "http://#{plug.id}/HNAP1"
  end

  def login_headers
    {
      "Content-Type" => "text/xml; charset=utf-8",
      "SOAPAction" => "http://purenetworks.com/HNAP1/Login"
    }
  end

  def login_body
    <<~XML
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
  end

  def login_result(parsed_xml)
    parsed_xml.xpath('//LoginResult')
  end

  def challenge(parsed_xml)
    parsed_xml.xpath("//Challenge")
  end

  def public_key(parsed_xml)
    parsed_xml.xpath("//PublicKey")
  end

  def cookie(parsed_xml)
    parsed_xml.xpath("//Cookie")
  end

  def private_key(parsed_xml)
    "#{public_key(parsed_xml)} #{plug.login_password(parsed_xml)} #{challenge(parsed_xml)}".upcase
  end
end
