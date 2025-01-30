# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# User.create!(
#   first_name: 'Abhijeet',
#   last_name: 'Lokhande',
#   phone_no: '1234567890',
#   email: 'abhi.lokhande@gmail.com',
#   password: 'password123',
#   gender: 'Male',
#   age: 22 
# )



Admin.create!(
  first_name: 'Rajesh',
  last_name: 'Verma',
  email: 'rajesh.verma@admin.com',
  password: 'admin123',
)