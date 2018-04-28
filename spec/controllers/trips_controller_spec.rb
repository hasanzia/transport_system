require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  let(:company) { Company.create(name: "some") }
  let!(:user) { create :user, company: company }
  let!(:admin_user) { create :admin_user }
  let!(:vehicle) { create :vehicle, company: company}
  let!(:trip) { create :trip, company: company, vehicle: vehicle, user: user, starting_at: DateTime.now - 1.day, ending_at: DateTime.now + 2.days}
  let!(:trip2) { create :trip, company: company, vehicle: vehicle, user: user, starting_at: DateTime.now + 4.days, ending_at: DateTime.now + 7.days}

  describe "#index" do
    before do
      sign_in(user)
    end

    it "gets all trips for given user" do
      get :index, params: {
        starting_at: DateTime.now - 1.day,
        ending_at: DateTime.now + 2.days,
        user_id: user.id
      }

      expect(response).to have_http_status(200)
    end

    it "gets all trips for given vehicle" do
      get :index, params: {
        starting_at: DateTime.now - 1.day,
        ending_at: DateTime.now + 2.days,
        vehicle_id: vehicle.id
      }

      expect(response).to have_http_status(200)
    end

    it "gets all trips for given user and vehicle" do
      get :index, params: {
        starting_at: DateTime.now - 1.day,
        ending_at: DateTime.now + 2.days,
        vehicle_id: vehicle.id
      }

      expect(response).to have_http_status(200)
    end

    it "gets all trips" do
      get :index, params: {
        starting_at: DateTime.now - 1.day,
        ending_at: DateTime.now + 2.days,
      }

      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    before do
      sign_in(admin_user)
    end

    it "creates trips in bulk" do
      expect {
        post :create, params: {
          trips: [
            {
              user_id: user.id,
              vehicle_id: vehicle.id,
              starting_at: DateTime.now - 3.days,
              ending_at: DateTime.now - 2.days,
              distance_travelled: 123
            },
            {
              user_id: user.id,
              vehicle_id: vehicle.id,
              starting_at: DateTime.now - 8.days,
              ending_at: DateTime.now - 7.days,
              distance_travelled: 123
            }
          ]
        }
      }.to change { Trip.count }
      expect(response).to have_http_status(201)
    end

    it "validates and rolls back all trip creations upon single failure" do
      expect {
        post :create, params: {
          trips: [
            {
              user_id: user.id,
              vehicle_id: vehicle.id,
              starting_at: DateTime.now - 3.days,
              ending_at: DateTime.now - 2.days,
              distance_travelled: 23432
            },
            {
              user_id: user.id,
              vehicle_id: vehicle.id,
              starting_at: DateTime.now - 4.days,
              ending_at: DateTime.now + 2.days,
              distance_travelled: 23432
            }
          ]
        }
      }.not_to change { Trip.count }
      expect(response).to have_http_status(400)
    end
  end

  describe "#trips_summary" do
    before do
      sign_in(user)
    end

    it "validates for user and vehicle either to be present" do
      get :trips_summary, params: {
        starting_at: DateTime.now - 1.days,
        ending_at: DateTime.now + 2.days,
      }

      expect(response).to have_http_status(422)
    end

    it "gets trip summary for given user" do
      get :trips_summary, params: {
        starting_at: DateTime.now - 5.days,
        ending_at: DateTime.now + 5.days,
        user_id: user.id
      }

      expect(response).to have_http_status(200)
    end

    it "gets trip summary for given vehicle" do
      get :trips_summary, params: {
        starting_at: DateTime.now - 5.days,
        ending_at: DateTime.now + 5.days,
        vehicle_id: vehicle.id
      }

      expect(response).to have_http_status(200)
    end
  end
end
