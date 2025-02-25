
user1 = User.create!(
  first_name: 'John',
  last_name: 'Doe',
  phone_no: '1234567891',
  email: 'john.doe1@example.com',
  password: 'password',
  gender: 'Male',
  age: 30
)

user2 = User.create!(
  first_name: 'Jane',
  last_name: 'Smith',
  phone_no: '9876543211',
  email: 'jane.smith1@example.com',
  password: 'password',
  gender: 'Female',
  age: 28
)

user3 = User.create!(
  first_name: 'Jane',
  last_name: 'Smith',
  phone_no: '9876543211',
  email: 'abhijeetlokhande2580@gmail.com',
  password: 'password',
  gender: 'Female',
  age: 28
)

admin = Admin.create!(
  first_name: 'Admin',
  last_name: 'User',
  email: 'admin1@example.com',
  password: 'adminpassword'
)

ride = Ride.create!(
  passenger_id: user1.id,
  rider_id: admin.id,
  starting_coordinates: '40.7128,-74.0060',
  ending_coordinates: '34.0522,-118.2437',
  price: 100.0,
  status: 'pending'
)

booking = Booking.create!(
  ride_id: ride.id,
  status: 'booked'
)

rating = Rating.create!(
  ride_id: ride.id,
  user_id: user2.id,
  rating: 5,
  review: 'Great ride, smooth journey!'
)

puts "Seed data created successfully!"
