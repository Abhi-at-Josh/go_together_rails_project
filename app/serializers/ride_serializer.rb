  class RideSerializer < ActiveModel::Serializer
    attributes :id, :passenger_name, :rider_name, :starting_coordinates, :ending_coordinates, :price, :status
    def passenger_name
      "#{object.passenger&.first_name} #{object.passenger&.last_name}".strip
    end
  
    def rider_name
      "#{object.rider&.first_name} #{object.rider&.last_name}".strip
    end
  end
