class Plug < ApplicationRecord
  has_many :data_files
  has_many :readings
  has_many :hnap_logins

  validates :name, presence: true
  validates :ip_address, format: { with: /\d{1,3}[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}/, message: 'must be a valid ip address' }
end
