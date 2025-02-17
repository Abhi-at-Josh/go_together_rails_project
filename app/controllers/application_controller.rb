class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request, except: [:index, :show]

  private

  def authenticate_request
    header = request.headers["Authorization"]
    return render json: { error: "Token missing" }, status: :unauthorized if header.blank?

    token = header.split(" ").last
    begin
      decoded = jwt_decode(token)
      @current_user = authenticate_user_or_admin(decoded)
    rescue JWT::DecodeError => e
      render json: { error: "Invalid token: #{e.message}" }, status: :unauthorized
    end
  end

  def authenticate_user_or_admin(decoded)
    if decoded[:user_type] == 'admin'
      Admin.find(decoded[:user_id])  # Fetch admin if it's an admin token
    else
      User.find(decoded[:user_id])  # Default to User if it's a regular user token
    end 
  end
end
