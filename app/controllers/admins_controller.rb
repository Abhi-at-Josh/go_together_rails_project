class AdminsController < ApplicationController
  skip_before_action :authenticate_request, only: [ :signup, :login ]
  before_action :set_admin, only: [ :show, :update, :destroy ]

  # POST /admins/signup
  def signup
    @admin = Admin.new(admin_params)
    if @admin.save
      token = jwt_encode(admin_id: @admin.id)  # Generate JWT token
      render json: { admin: @admin, token: token }, status: :created
    else
      render json: { error: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /admins/login
  def login
    @admin = Admin.find_by_email(params[:email])
    if @admin&.authenticate(params[:password])
      token = jwt_encode(admin_id: @admin.id)
      render json: { token: token }, status: :ok
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
    @admin.destroy
    render json: { message: "Admin deleted successfully" }, status: :ok
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
