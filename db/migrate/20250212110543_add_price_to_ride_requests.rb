class AddPriceToRideRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :ride_requests, :price, :decimal, precision: 10, scale: 2
  end
end
