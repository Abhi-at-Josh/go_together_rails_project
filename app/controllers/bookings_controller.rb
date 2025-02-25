class BookingsController < ApplicationController
  # GET /bookings
  def index
    @booking = Booking.all
    render json: @booking
  end

  # GET /booking/:id
  def show
    @booking = Booking.find(params[:id])
    render json: @booking
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)
    if @ride.save
      render json: @booking, status: :created
    else
      render json: @booking.error, status: :unauthorized
    end
  end

  # DELETE /bookings/:id
  def destroy
    @booking = Booking.find_by(id: params[:id])
    if @booking
      @booking.destroy
      head :no_content
    else
      render json: { error: "Booking not found" }, status: :not_found
    end
  end


  private
  def booking_params
    params.require(:booking).parmit(:ride_id, :rating_id, :status)
  end

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    decode_token = decode_token(token)
    if decode_token
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
