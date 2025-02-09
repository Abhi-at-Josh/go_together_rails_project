class User < ApplicationRecord
  # require "securerandom"
  # require 'rails_helper'

  has_secure_password

  validates :first_name, :last_name, :phone_no, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_no, uniqueness: true
end
