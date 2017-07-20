class Reading < ApplicationRecord
  validates :date_time, presence: true
  validates :consumption, presence: true
end
