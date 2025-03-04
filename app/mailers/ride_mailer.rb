class RideMailer < ApplicationMailer
  default from: "abhijeetlokhande2580@gmail.com"

  def booking_request_email(rider_email, passenger_name, rider_name)
    @passenger_name = passenger_name
    @rider_name = rider_name

    mail(
      to: rider_email, 
      subject: "Go-Together! Booking Request"
    )
  end

  def request_except_reject_email(passenger_email, passenger_name , rider_name ,status)
    @passenger_email=passenger_email;
    @rider_name = rider_name;
    @status = status;
    @passenger_name = passenger_name; 
     
     mail(
      to:passenger_email,
      subject:"Go-Together! Booking Request"
     )
  end
end
