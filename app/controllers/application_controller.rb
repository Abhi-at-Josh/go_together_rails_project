class ApplicationController < ActionController::API
  include ActionController::Flash
  include JsonWebToken

  # before_action :authenticate_request, except: [:index, :show]
  before_action :authenticate_request, unless: -> { devise_controller? }, except: [ :index, :show ]
  private

  def authenticate_request
    header = request.headers["Authorization"]
    return render json: { error: "Token missing" }, status: :unauthorized if header.blank?

    token = header.split(" ").last
    begin
      decoded = jwt_decode(token)
      Rails.logger.debug("Decoded JWT: #{decoded}")
      @current_user = authenticate_user_or_admin(decoded)
    rescue JWT::DecodeError => e
      render json: { error: "Invalid token: #{e.message}" }, status: :unauthorized
    end
  end

  def authenticate_user_or_admin(decoded)
    Rails.logger.debug("Decoded user_type: #{decoded[:user_type]}")
    if decoded[:user_type] == "admin"
      Admin.find(decoded[:admin_id])  # Fetch admin if it's an admin token
    elsif decoded[:user_type] == "user"
      User.find(decoded[:user_id])  # Default to User if it's a regular user token
    else
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end
end
