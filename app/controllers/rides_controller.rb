class RidesController < ApplicationController
  # before_action :authenticate_user
  # GET /rides
  def index
    @rides = Ride.includes(:passenger, :rider)
    render json: @rides, each_serializer: RideSerializer, status: :ok
  end

  # GET /rides/:id  
  def show
    @ride = Ride.where(rider_id:params[:id])
    render json: @ride , each_serializer: RideSerializer, status: :ok
  end 

  # POST /rides
  def create
    passenger_id = @current_user.id  
    # ride_request_id = @current_user.ride_request_id  
    
    ride_request = RideRequest.find_by(id:params[:ride_request_id])  
    unless ride_request
      return render json: { error: "Ride request not found" }, status: :not_found
    end

    rider = User.find_by(id: ride_request.requester_id)
    unless rider
      return render json: { error: "Requester not found" }, status: :unprocessable_entity
    end

  # Create Ride
    @ride = Ride.new(
      passenger_id: passenger_id,  
      rider_id: rider.id,         
      starting_coordinates: ride_request.starting_coordinates,
      ending_coordinates: ride_request.ending_coordinates,
      price: ride_request.price,
      status: "requested",
      ride_time: ride_request.ride_time  # Use time from ride request
    )
    if @ride.save
        passenger = User.find_by(id: passenger_id)  # Fetch passenger
        passenger_name = passenger.first_name
        rider_name = rider.first_name
        rider_email = rider.email
        RideMailer.booking_request_email(rider_email,passenger_name ,rider_name).deliver_now
      render json: @ride, status: :created
    else
      render json: @ride.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rides/:id
  def update
    @ride = Ride.find_by(rider_id: params[:id])
    status = @ride.status;
   return render json: { error: "Ride not found for this rider" }, status: :not_found  unless @ride

   passenger = User.find_by(id: @ride.passenger_id)
   rider = User.find_by(id: @ride.rider_id)

    if @ride.update(ride_params)
      passenger_email = passenger.email
      passenger_name = passenger.first_name
      rider_name = rider.first_name
      RideMailer.request_except_reject_email(passenger_email, passenger_name , rider_name ,status)
      render json: @ride
    else
      render json: @ride.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rides/:id
  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy
    head :no_content
  end

  private

  def ride_params
    params.require(:ride).permit( :status)
  end

end
