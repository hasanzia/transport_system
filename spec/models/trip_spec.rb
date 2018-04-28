# == Schema Information
#
# Table name: trips
#
#  id                 :bigint(8)        not null, primary key
#  description        :text
#  distance_travelled :float
#  ending_at          :datetime
#  starting_at        :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :bigint(8)
#  user_id            :bigint(8)
#  vehicle_id         :bigint(8)
#
# Indexes
#
#  index_trips_on_company_id  (company_id)
#  index_trips_on_user_id     (user_id)
#  index_trips_on_vehicle_id  (vehicle_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (vehicle_id => vehicles.id)
#

require 'rails_helper'

RSpec.describe Trip, type: :model do

  it { should belong_to(:company) }
  it { should belong_to(:user) }
  it { should belong_to(:vehicle) }

  it { should validate_presence_of(:starting_at) }

  let!(:company) { create :company }

  let!(:vehicle) { create :vehicle, company: company}
  let!(:vehicle2) { create :vehicle, company: company }
  let!(:user) { create :user, company: company }
  let!(:user2) { create :user, company: company }

  describe "Completed Trip should not overlap other Trip of same User in same time" do

    it "cannot create a trip coming in between a previous on going trip" do

      expect {
        trip = Trip.create(user_id: user.id, vehicle_id: vehicle.id, company_id: company.id, starting_at: DateTime.now - 5.days, ending_at: DateTime.now + 5.days, distance_travelled: 500)
      }.to change { Trip.count }

      expect {
        trip2 = Trip.create(user_id: user.id, vehicle_id: vehicle2.id, company_id: company.id, starting_at: DateTime.now - 2.days, ending_at: DateTime.now + 2.days, distance_travelled: 500)
      }.not_to change { Trip.count }
    end

    it "cannot create a trip overlapping with already on going trip" do

      expect {
        trip = Trip.create(user_id: user.id, vehicle_id: vehicle.id, company_id: company.id, starting_at: DateTime.now - 2.days, ending_at: DateTime.now + 2.days, distance_travelled: 500)
      }.to change { Trip.count }

      expect {
        trip2 = Trip.create(user_id: user.id, vehicle_id: vehicle2.id, company_id: company.id, starting_at: DateTime.now - 5.days, ending_at: DateTime.now + 5.days, distance_travelled: 500)
      }.not_to change { Trip.count }

    end
  end

  describe "Completed Trip should not overlap other Trip of same Vehicle in same time" do

    it "cannot create a trip coming in between a previous on going trip" do

      expect {
        trip = Trip.create(user_id: user.id, vehicle_id: vehicle.id, company_id: company.id, starting_at: DateTime.now - 5.days, ending_at: DateTime.now + 5.days, distance_travelled: 500)
      }.to change { Trip.count }

      expect {
        trip2 = Trip.create(user_id: user2.id, vehicle_id: vehicle.id, company_id: company.id, starting_at: DateTime.now - 2.days, ending_at: DateTime.now + 2.days, distance_travelled: 500)
      }.not_to change { Trip.count }

    end

    it "cannot create a trip overlapping with already on going trip" do

      expect {
        trip = Trip.create(user_id: user.id, vehicle_id: vehicle.id, company_id: company.id, starting_at: DateTime.now - 2.days, ending_at: DateTime.now + 2.days, distance_travelled: 500)
      }.to change { Trip.count }

      expect {
        trip2 = Trip.create(user_id: user2.id, vehicle_id: vehicle.id, company_id: company.id, starting_at: DateTime.now - 5.days, ending_at: DateTime.now + 5.days, distance_travelled: 500)
      }.not_to change { Trip.count }


    end
  end
end
