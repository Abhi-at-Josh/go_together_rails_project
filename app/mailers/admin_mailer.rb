class AdminMailer < ApplicationMailer
  default from: "abhijeetlokhande2580@gmail.com"

  def login_notification(admin)
    @admin = admin
    mail(to: @admin.email, subject: "Login Notification")
  end
end
