class PasswordResetMailer < ApplicationMailer
  default from: "abhijeetlokhande2580@gmail.com"

  def reset_password_email
    @user = params[:user]
    @reset_password_link = edit_password_reset_url(@user.reset_password_token)

    mail(to: @user.email, subject: "Reset Your Password")
  end
end
