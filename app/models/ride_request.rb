class RideRequest < ApplicationRecord
  belongs_to :requester, class_name: "User"
  VEHICLE_TYPES = ["two-wheel", "4-wheeler-1", "4-wheeler-2", "4-wheeler-3"].freeze

  # Validations
  validates :requester_id, presence: true
  validates :starting_coordinates, presence: true, length: { maximum: 255 }
  validates :ending_coordinates, presence: true, length: { maximum: 255 }
  validates :ride_time, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending matched cancelled],
                                                  message: "%{value} is not a valid status" }

  # Ensure starting and ending coordinates are not the same
  validate :different_start_and_end_locations
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :vehicle_type, presence: true, inclusion: { in: VEHICLE_TYPES, message: "%{value} is not a valid vehicle type" }
  private

  def different_start_and_end_locations
    if starting_coordinates == ending_coordinates
      errors.add(:ending_coordinates, "must be different from starting coordinates")
    end
  end
end
