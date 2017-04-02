require 'ffaker'

5.times {  Doctor.create( { first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name } ) }
@doctors = Doctor.all
@doctors.each do |doctor|
  3.times do
    Review.create( doctor: doctor, description: FFaker::Lorem.sentence,
    ratings: rand(1..5), reviewer: FFaker::Name.name)
  end
end
