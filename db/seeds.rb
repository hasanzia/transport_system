# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  puts '*****************************************************************'

  company = Company.find_or_create_by!(name: 'Keep Truckin', address: '28-J CCA, Lahore Cantt, Sector C Phase 5 D.H.A, Lahore, Punjab')

  admin = User.find_or_create_by!(email: 'admin@example.com', first_name: 'Admin', last_name: 'User', role: User.roles[:admin], address: 'Admin User Sample Address', company: company) do |admin|
    admin.password = 'password'
    admin.password_confirmation = 'password'
  end

  if admin.present?
    puts ''
    puts '*********************************************'
    puts 'Admin User Details'
    puts "ID: #{admin.id}"
    puts "email: #{admin.email}"
    puts "password: #{admin.password}"
    puts "authentication_token: #{admin.authentication_token}"
    puts '*********************************************'
  end

  user = User.find_or_create_by!(email: 'user@example.com', first_name: 'Normal', last_name: 'User', role: User.roles[:user], address: 'Normal User Sample Address', company: company) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end

  if user.present?
    puts ''
    puts '*********************************************'
    puts 'Normal User Details'
    puts "ID: #{user.id}"
    puts "email: #{user.email}"
    puts "password: #{user.password}"
    puts "authentication_token: #{user.authentication_token}"
    puts '*********************************************'
  end

  another_user = User.find_or_create_by!(email: 'another_user@example.com', first_name: 'Another Normal', last_name: 'User', role: User.roles[:user], address: 'Another Normal User Sample Address', company: company) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end

  if another_user.present?
    puts ''
    puts '*********************************************'
    puts 'Another Normal User Details'
    puts "ID: #{another_user.id}"
    puts "email: #{another_user.email}"
    puts "password: #{another_user.password}"
    puts "authentication_token: #{another_user.authentication_token}"
    puts '*********************************************'
  end

  vehicle1 = Vehicle.find_or_create_by(registration_number: 'LZN 886', type: Vehicle.types[:truck], description: "Company's first truck", company: company)

  if vehicle1.present?
    puts ''
    puts '*********************************************'
    puts 'Vehicle1 Details'
    puts "ID: #{vehicle1.id}"
    puts "registration_number: #{vehicle1.registration_number}"
    puts "description: #{vehicle1.description}"
    puts '*********************************************'
  end

  vehicle2 = Vehicle.find_or_create_by(registration_number: 'LZN 887', type: Vehicle.types[:truck], description: "Company's second truck", company: company)

  if vehicle2.present?
    puts ''
    puts '*********************************************'
    puts 'Vehicle2 Details'
    puts "ID: #{vehicle2.id}"
    puts "registration_number: #{vehicle2.registration_number}"
    puts "description: #{vehicle2.description}"
    puts '*********************************************'
  end

  vehicle3 = Vehicle.find_or_create_by(registration_number: 'LZN 888', type: Vehicle.types[:truck], description: "Company's third truck", company: company)

  if vehicle3.present?
    puts ''
    puts '*********************************************'
    puts 'Vehicle3 Details'
    puts "ID: #{vehicle3.id}"
    puts "registration_number: #{vehicle3.registration_number}"
    puts "description: #{vehicle3.description}"
    puts '*********************************************'
  end

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

  puts ''
  puts '*****************************************************************'
