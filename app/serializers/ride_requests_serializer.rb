class RideRequestsSerializer < ActiveModel::Serializer
    attributes :id, :requester_id, :starting_coordinates, :ending_coordinates, :ride_time, :status
end