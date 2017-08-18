class HnapLogin < ApplicationRecord
  belongs_to :plug

  def private_key
    # TODO: HMAC_MD5 this
    "#{public_key}#{plug.login_password}#{challenge}".upcase
  end
end
