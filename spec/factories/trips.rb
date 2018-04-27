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

FactoryBot.define do
  factory :trip do
    starting_at "2018-04-27 16:18:18"
    ending_at "2018-04-27 16:18:18"
    distance_travelled 1.5
    company nil
    user nil
    vehicle nil
  end
end
