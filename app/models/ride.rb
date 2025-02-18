class Ride < ApplicationRecord
  belongs_to :passenger, class_name: 'User'
  belongs_to :rider, class_name: 'User'

  has_many :ratings
  has_many :bookings

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :starting_coordinates, :ending_coordinates, :status, presence: true
end

