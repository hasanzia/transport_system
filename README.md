# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Clone the repo: git clone https://github.com/hasanzia/transport_system.git

* Switch to the repo directory: cd transport_system

* If you're using RVM then install Ruby version 2.5.1 and Rails version 5.2: rvm install 2.5.1 && rvm use 2.5.1 && rvm gemset use transport_system --create && gem install bundler && bundle install

* Database setup: rails db:setup (please update config/database.yml to reflect correct user with password as per your local Postgresql setup)

* After the above setup you can view seed data displayed in the terminal, please note the ids of User, Vehicle, Trip and authentication_token of User for API endpoints to authenticate

* run rails server on port 3000 in a new tab: rails s -p 3000

* User Credentials:

- Admin User: email=admin@example.com password=password

- Normal User: email=user@example.com password=password

- Another Normal User: email=another_user@example.com password=password

* Now in order to test the API endpoints you can either use CURL or my favorite httpie (Installation: https://github.com/jakubroztocil/httpie#macos)

* httpie examples to test the API endpoints:

- Simple Authentication to get User Details with authentication_token: http -f POST http://localhost:3000/auth 'user[email]=admin@example.com' 'user[password]=password'
- Create Trips in bulk only authenticate-able by an admin user http POST http://localhost:3000/trips 'auth_token=<admin authentication_token>' trips:='[{"user_id": 2,"vehicle_id": 1,"starting_at": "2018-04-24 14:37:02.13550","ending_at":"2018-04-24 15:37:02.13550","distance_travelled": 23432},{"user_id": 3,"vehicle_id": 2,"starting_at": "2018-04-25 14:37:02.13550","ending_at": "2018-04-25 15:37:02.13550","distance_travelled": 23432}]'
- Or create trips in bulk without authentication_token and instead email with password: http POST http://localhost:3000/trips 'email=admin@example.com' 'password=password' trips:='[{"user_id": 2,"vehicle_id": 1,"starting_at": "2018-04-24 14:37:02.13550","ending_at":"2018-04-24 15:37:02.13550","distance_travelled": 23432},{"user_id": 3,"vehicle_id": 2,"starting_at": "2018-04-25 14:37:02.13550","ending_at": "2018-04-25 15:37:02.13550","distance_travelled": 23432}]'
- Get trips upon vehicle_id, or user_id or both. Please note that starting_at with ending_at is mandatory to this endpoint: http GET http://localhost:3000/trips 'auth_token=<authentication_token>' 'vehicle_id=1' 'user_id=2' "starting_at=2018-04-23" "ending_at=2018-04-26"
- If you forget the authentication_token you can always get it from: http -f POST http://localhost:3000/auth 'user[email]=admin@example.com' 'user[password]=password'
- Now in order to view the trip summary please use this endpoint and note that starting_at with ending_at is mandatory to this endpoint with either a user_id or a vehicle_id is also mandatory: http GET http://localhost:3000/trips_summary 'auth_token=<authentication_token>' 'user_id=2' "starting_at=2018-04-23" "ending_at=2018-04-26"

* Now last but not least, test all the Unit and Functional test cases by running: rspec

* Also you can backup your six month old trips in a separate database by: rails backup:six_month_old_trips

