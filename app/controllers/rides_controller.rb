class RidesController < ApplicationController
  # before_action :authenticate_user!
  # GET /rides
  def index
    @rides = Ride.all
    render json: @rides, each_serializer: RideSerializer, status: :ok
  end

  # GET /rides/:id
  def show
    @ride = Ride.find(params[:id])
    render json: @ride
  end

  # POST /rides
  def create
    @ride = Ride.new(ride_params)
    if @ride.save
      render json: @ride, status: :created
    else
      render json: @ride.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rides/:id
  def update
    @ride = Ride.find(params[:id])
    if @ride.update!(ride_params)
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
    params.require(:ride).permit(:passenger_id, :rider_id, :starting_coordinates, :ending_coordinates, :price, :status)
  end

  # Ensure user is authenticated via JWT
  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded_token = decode_token(token)
    if decoded_token
      @current_user = User.find(decoded_token[:user_id])
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secret_key_base).first
  rescue JWT::DecodeError
    nil
  end
end
