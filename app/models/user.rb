class User < ApplicationRecord
  # require "securerandom"
  # require 'rails_helper'
  after_create :send_welcome_email
  has_secure_password

  validates :first_name, :last_name, :phone_no, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_no, uniqueness: true

  private
   def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
   end
end
