class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.references :ride, null: false, foreign_key: true
      t.references :rating, null: true, foreign_key: true
      t.string :status, default: 'booked'
      t.timestamps
    end
  end
end
