class User < ApplicationRecord
  validates :first_name, :last_name, :phone_no, :email, presence: true
  validates :email, uniqueness: true
  validates :phone_no, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
