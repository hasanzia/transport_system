# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  company = Company.find_or_create_by!(name: 'Keep Truckin', address: '28-J CCA, Lahore Cantt, Sector C Phase 5 D.H.A, Lahore, Punjab')

  admin = User.find_or_create_by!(email: 'admin@example.com', first_name: 'Admin', last_name: 'User', role: User.roles[:admin], address: 'Admin User Sample Address', company: company) do |admin|
    admin.password = 'password'
    admin.password_confirmation = 'password'
  end

  user = User.find_or_create_by!(email: 'user@example.com', first_name: 'Normal', last_name: 'User', role: User.roles[:user], address: 'Normal User Sample Address', company: company) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end

  another_user = User.find_or_create_by!(email: 'another_user@example.com', first_name: 'Another Normal', last_name: 'User', role: User.roles[:user], address: 'Another Normal User Sample Address', company: company) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end

  vehicle1 = Vehicle.find_or_create_by(registration_number: 'LZN 886', type: Vehicle.types[:truck], description: "Company's first truck", company: company)
  vehicle2 = Vehicle.find_or_create_by(registration_number: 'LZN 887', type: Vehicle.types[:truck], description: "Company's second truck", company: company)
  vehicle3 = Vehicle.find_or_create_by(registration_number: 'LZN 888', type: Vehicle.types[:truck], description: "Company's third truck", company: company)

  trip1 = Trip.find_or_create_by(distance_travelled: 30.6, description: "Delivery by #{user.first_name}", company: company, user: user, vehicle: vehicle1) do |trip|
    trip.starting_at = 3.days.ago
    trip.ending_at = 3.days.ago + 1.hours
  end

  trip2 = Trip.find_or_create_by(distance_travelled: 50.6, description: "Delivery by #{another_user.first_name}", company: company, user: another_user, vehicle: vehicle2) do |trip|
    trip.starting_at = 3.days.ago
    trip.ending_at = 3.days.ago + 2.hours
  end

  trip3 = Trip.find_or_create_by(distance_travelled: 80.6, description: "Delivery by #{user.first_name}", company: company, user: user, vehicle: vehicle3) do |trip|
    trip.starting_at = 2.days.ago
    trip.ending_at = 2.days.ago + 6.hours
  end
