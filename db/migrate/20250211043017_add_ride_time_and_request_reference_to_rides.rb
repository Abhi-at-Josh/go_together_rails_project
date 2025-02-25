class AddRideTimeAndRequestReferenceToRides < ActiveRecord::Migration[7.2]
  def change
    # Add ride_time with a default value first (e.g., "00:00:00")
    add_column :rides, :ride_time, :time, default: "00:00:00", null: false

    # Add ride_request_id reference (nullable initially)
    add_reference :rides, :ride_request, foreign_key: true
  end
end
