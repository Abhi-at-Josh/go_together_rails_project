class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request, except: [:index, :show, :login, :signup]

  private

  def authenticate_request
    header = request.headers["Authorization"]
    return render json: { error: "Token missing" }, status: :unauthorized if header.blank?

    token = header.split(" ").last
    begin
      decoded = jwt_decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError => e
      render json: { error: "Invalid token: #{e.message}" }, status: :unauthorized
    end
  end
end
