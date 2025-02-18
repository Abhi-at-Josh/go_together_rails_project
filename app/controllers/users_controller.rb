class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:signup, :login, :index, :show]
    before_action :set_user, only: [:show, :update, :destroy]
  
    # GET /users
    def index
      @users = User.all
      render json: @users, status: :ok
    end
  
    # GET /users/{id}
    def show
      render json: @user, status: :ok
    end
  
    # POST /users/signup
    def signup
      @user = User.new(user_params)
      if @user.save!
        token = jwt_encode(user_id: @user.id)
        render json: { user: @user, token: token }, status: :created
      else
        render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # POST /users/login
    def login
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        token = jwt_encode(user_id: @user.id)
        render json: { user: @user, token: token }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end
  
    # PUT /users/{id}
    def update
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /users/{id}
    def destroy
      @user.destroy
      render json: { message: "User deleted successfully" }, status: :ok
    end
  
    private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_no, :password, :password_confirmation, :gender, :age)
    end
  
    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end
  