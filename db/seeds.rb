# db/seeds.rb

# Create users with unique emails and phone numbers
user1 = User.create!(
  first_name: 'John',
  last_name: 'Doe',
  phone_no: '1234567891',  # Unique phone number
  email: 'john.doe1@example.com',  # Unique email
  password: 'password',  # Set password directly (Rails will handle hashing)
  gender: 'Male',
  age: 30
)

user2 = User.create!(
  first_name: 'Jane',
  last_name: 'Smith',
  phone_no: '9876543211',  # Unique phone number
  email: 'jane.smith1@example.com',  # Unique email
  password: 'password',  # Set password directly (Rails will handle hashing)
  gender: 'Female',
  age: 28
)

# Create admins with unique emails
admin = Admin.create!(
  first_name: 'Admin',
  last_name: 'User',
  email: 'admin1@example.com',  # Unique email
  password: 'adminpassword'  # Set password directly (Rails will handle hashing)
)

# Create rides
ride = Ride.create!(
  passenger_id: user1.id,
  rider_id: admin.id,
  starting_coordinates: '40.7128,-74.0060',  # New York
  ending_coordinates: '34.0522,-118.2437',  # Los Angeles
  price: 100.0,
  status: 'pending'
)

# Create bookings
booking = Booking.create!(
  ride_id: ride.id,
  status: 'booked'
)

# Create ratings
rating = Rating.create!(
  ride_id: ride.id,
  user_id: user2.id,
  rating: 5,
  review: 'Great ride, smooth journey!'
)

puts "Seed data created successfully!"
