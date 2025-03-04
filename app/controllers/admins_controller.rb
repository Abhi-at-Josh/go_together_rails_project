class AdminsController < ApplicationController
  skip_before_action :authenticate_request, only: [ :signup, :login, :users_index, :rides_show, :ratings, :bookings, :users_show  ,:destroy  ]
  before_action :set_admin, only: [ :show, :update ]

  # POST /admins/signup
  def signup
    @admin = Admin.new(admin_params)
    if @admin.save
      token = jwt_encode(admin_id: @admin.id, user_type: "admin")
      AdminMailer.login_notification(@admin).deliver_later
      render json: { admin: @admin, token: token }, status: :created
    else
      render json: { error: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /admins/login
  def login
    @admin = Admin.find_by_email(params[:email])
    if @admin&.valid_password?(params[:password])
      token = jwt_encode(admin_id: @admin.id, user_type: "admin")
      AdminMailer.login_notification(@admin).deliver_later
      render json: { token: }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # GET /admins
  def index
    @admins = Admin.all
    render json: @admins, each_serializer: AdminSerializer, status: :ok
  end

  # GET /admins/:id
  def show
    render json: @admin, each_serializer: AdminSerializer, status: :ok
  end

  # PUT /admins/:id
  def update
    if @admin.update(admin_params)
      render json: @admin, status: :ok
    else
      render json: { error: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /admins/:id
  def destroy
    @admin = Admin.find(params[:id])

    if @admin
      @admin.destroy
      render json: { message: "Admin deleted successfully" }, status: :ok
    else
      render json: { error: "Admin not found" }, status: :not_found
    end
  end


  # Admin manages users CRUD
  # GET /admins/users
  def users_index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /admins/users/:id
  def users_show  
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  # PUT /admins/users/:id
  def users_update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /admins/users/:id
  def users_destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: "User deleted successfully" }, status: :ok
  end

  # Admin manages rides CRUD
  # GET /rides
  def rides_show
    @rides=Ride.all
    render json: @rides, status: :ok
  end

  # Admin manages rating CRUD
  # GET /ratings
  def ratings
    @ratings=Rating.all
    render json: @ratings, status: :ok
  end

  # Admin manages bookings CRUD
  # GET /bookings
  def bookings
    @bookings = Booking.all
    render json: @bookings, status: :ok
  end

  def ride_request
    @ride_requests  = RideRequest.all
    render josn: @booking , status: :ok 
  end


  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.permit(:first_name, :last_name, :email, :password)
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :phone_no, :password, :password_confirmation, :gender, :age)
  end

  def authorize_admin
    return if @current_user && @current_user.user_type == "admin"

    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
