class RideRequestsController < ApplicationController
  before_action :set_ride_request, only: [ :show, :update ,:destroy ,:booking ]
  skip_before_action :authenticate_request, only: [:destroy ]
  # GET /ride_requests
  def index
    ride_requests = RideRequest.includes(:requester) # Include requester for better performance
    render json: {
      status: "success",
      rides: ride_requests.map do |ride|
        {
          ride_id: ride.id,
          user_name: "#{ride.requester.first_name} #{ride.requester.last_name}",
          user_age: ride.requester.age,
          starting_coordinates: ride.starting_coordinates,
          ending_coordinates: ride.ending_coordinates,
          ride_time: ride.ride_time,
          vehicle_type: ride.vehicle_type,
          status: ride.status,
          price: ride.price
        }
      end
    }, status: :ok
  end
  # GET /ride_requests/:id
  def show  
    render json: @ride_request, each_serializer: RideRequestsSerializer, status: :ok
  end

  # POST /ride_requests
  def create
    ride_request = RideRequest.new(ride_request_params)
    ride_request.requester_id = @current_user.id if @current_user
    if ride_request.save
      RideStatusUpdateJob.perform_later
      render json: ride_request, status: :created
    else
      render json: { errors: ride_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /ride_requests/:id
  def update
    if @ride_request.update(ride_request_params)
      render json: @ride_request, status: :ok
    else
      render json: { errors: @ride_request.errors.full_messages }, status: :unprocessable_entity
    end   
  end

  # DELETE /ride_requests/:id
  def destroy
    if @ride_request.destroy
      render json: { message: "Ride request deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete ride request" }, status: :unprocessable_entity
    end
  end

  # POST /booking ride
  def booking # Search by coordinates
    starting_coords = params[:starting_coordinates]
    ending_coords = params[:ending_coordinates]

    @rides = RideRequest.where(starting_coordinates: starting_coords, ending_coordinates: ending_coords)

    if @rides.any?
      render json: {
        status: "success",
        rides: @rides.map do |ride|
          {
            ride_id: ride.id,
            user_name: "#{ride.requester.first_name} #{ride.requester.last_name}",
            user_age: ride.requester.age,
            starting_coordinates: ride.starting_coordinates,
            ending_coordinates: ride.ending_coordinates,
            ride_time: ride.ride_time,
            vehicle_type: ride.vehicle_type,
            status: ride.status,
            price: ride.price
          }
        end
      }, status: :ok
    else
      render json: { status: "not_found", message: "No matching rides found" }, status: :not_found
    end
  end

  private

  # Find ride request before show, update, or delete
  def set_ride_request
    return if params[:id].blank?
    @ride_request = RideRequest.find_by(id: params[:id])

    unless @ride_request
      render json: { error: "Ride request not found" }, status: :not_found
    end
  end

  # Strong parameters
  def ride_request_params
    params.require(:ride_request).permit( :starting_coordinates, :ending_coordinates, :ride_time,  :price ,:vehicle_type)
  end
end
