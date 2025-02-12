class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [ :signup, :login, :index, :show , :update_password ,:destroy ]
    before_action :set_user, only: [ :show, :update,  ]
  
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
      if @user.save
        token = jwt_encode(user_id: @user.id,user_type:"user")

        UserMailer.welcome_email(@user).deliver_later
        render json: { user: @user, token: token }, status: :created
      else
        render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # POST /users/login
    def login
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        token = jwt_encode(user_id: @user.id,user_type: "user")
        UserMailer.welcome_email(@user).deliver_later
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
      @user = User.find_by(id: params[:id])
    
      if @user
        @user.destroy
        render json: { message: "User deleted successfully" }, status: :ok
      else
        render json: { error: "User not found" }, status: :not_found
      end
    end
      
    # POST /users/reset_password_request
    def create_reset_request
      @user = User.find_by(email: params[:email])
      
      if @user
        @user.generate_reset_password_token
        @user.save

        # Send email with reset password instructions (you can use a mailer here)
        PasswordResetMailer.with(user: @user).reset_password_email.deliver_later

        render json: { message: 'Password reset instructions have been sent to your email.' }, status: :ok
      else
        render json: { error: 'User not found with that email address.' }, status: :not_found
      end
    end

    # PATCH /users/reset_password
    def update_password
      @user = User.find_by(reset_password_token: params[:reset_password_token])

      if @user && @user.reset_password_token_valid?
        if @user.update(password: params[:password], reset_password_token: nil, reset_password_sent_at: nil)
          render json: { message: 'Password has been successfully updated.' }, status: :ok
        else
          render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Invalid or expired token.' }, status: :unprocessable_entity
      end
    end
      
    private

    def user_params
      params.permit(:first_name, :last_name, :email, :phone_no, :password, :password_confirmation, :gender, :age)
    end

    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
end
