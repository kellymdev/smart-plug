class Plug < ApplicationRecord
  validates :name, presence: true
  validates :ip_address, format: { with: /\d{1,3}[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}/, message: 'must be a valid ip address' }
end
