class CreateRides < ActiveRecord::Migration[7.2]
  def change
    create_table :rides do |t|
      t.integer :passenger_id
      t.integer :rider_id
      t.string :starting_coordinates
      t.string :ending_coordinates
      t.decimal :price
      t.string :status

      t.timestamps
    end
  end
end
