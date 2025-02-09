class RideSerializer < ActiveModel::Serializer
  attributes :id, :passenger_id, :rider_id, :starting_coordinates, :ending_coordinates, :price, :status
end
