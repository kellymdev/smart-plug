class Reading < ApplicationRecord
  belongs_to :plug

  validates :date_time, presence: true
  validates :consumption, presence: true
end
