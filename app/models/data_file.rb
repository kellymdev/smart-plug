class DataFile < ApplicationRecord
  belongs_to :plug

  validates :filename, presence: true
end

