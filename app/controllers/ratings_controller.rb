class RatingsController < ApplicationController
  # GET /rating
  def index
  @rating = Rating.all
  render json: @rating
  end

  # GET /rating/:id
  def show
  @rating = Rating.find(params[:id])
  render json: @rating
  end

  # POST /rating
  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      render json: @rating, status: :created
    else
      render json: @rating.error, status: :unprocessable_entity
    end
  end


  # DELETE /rides/:id
  def destroy
    @rating = Rating.find_by(id: params[:id])
    if @rating
      @rating.destroy
      head :no_content
    else
      render json: { error: "Rating not found" }, status: :not_found
    end
  end


  private
  def rating_params
    params.require(:rating).permit(:ride_id, :user_id, :rating, :review)
  end

  # Ensure user is authenticate via JWt
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
