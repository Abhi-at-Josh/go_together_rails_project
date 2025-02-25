class UserMailer < ApplicationMailer
  default from: "abhijeetlokhande2580@gmail.com"

  def welcome_email(user)
   @user= user
   mail(to: @user.email, subject: "Welcome to Go-Together!")
  end
end
