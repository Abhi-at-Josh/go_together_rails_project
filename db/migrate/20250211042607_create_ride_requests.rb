class CreateRideRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :ride_requests do |t|
      t.references :requester, null: false, foreign_key: { to_table: :users } # References users
      t.string :starting_coordinates, null: false
      t.string :ending_coordinates, null: false
      t.time :ride_time, null: false
      t.string :status, default: "pending", null: false

      t.timestamps
    end
    add_index :ride_requests, :status
  end
end
