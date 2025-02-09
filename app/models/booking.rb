class Booking < ApplicationRecord
  belongs_to :ride
  belongs_to :rating
  validates :status, presence: true, inclusion: { in: [ "booked", "cancelled", "completed" ] }
end
