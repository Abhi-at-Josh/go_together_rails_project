class RideStatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Find ride requests that are pending and have a ride_time in the past
    RideRequest.where("ride_time < ?", Time.current)
               .where(status: "pending")
               .update_all(status: "cancelled")
  end
end
