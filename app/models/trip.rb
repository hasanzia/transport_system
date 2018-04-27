# == Schema Information
#
# Table name: trips
#
#  id                 :bigint(8)        not null, primary key
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

class Trip < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :vehicle

  validates :starting_at, presence: true
  validate :completed_trip_should_have_duration, if: :ending_at
  validate :completed_trip_should_not_overlap_other_trip_of_same_user_in_same_time, if: :ending_at
  validate :completed_trip_should_not_overlap_other_trip_of_same_vehicle_in_same_time, if: :ending_at

  def completed_trip_should_have_duration
    errors.add(:ending_at, "cannot be smaller or equal to Starting at of a Trip") if ending_at <= starting_at
  end

  def completed_trip_should_not_overlap_other_trip_of_same_user_in_same_time
    if Trip.where.not(id: self.id).where(user_id: self.user_id).where(" ('#{self.starting_at}' BETWEEN starting_at AND ending_at) OR ( '#{self.ending_at}' BETWEEN starting_at AND ending_at) ").any?
      errors.add(:user_id, "user can't overlap older trip of same user in same time")
    elsif Trip.where.not(id: self.id).where(user_id: self.user_id).where(" (starting_at BETWEEN '#{self.starting_at}' AND '#{self.ending_at}') OR (ending_at BETWEEN '#{self.starting_at}' AND '#{self.ending_at}') ").any?
      errors.add(:user_id, "user can't overlap older trip of same user in same time")
    end
  end

  def completed_trip_should_not_overlap_other_trip_of_same_vehicle_in_same_time
    if Trip.where.not(id: self.id).where(vehicle_id: self.vehicle_id).where(" ('#{self.starting_at}' BETWEEN starting_at AND ending_at) OR ( '#{self.ending_at}' BETWEEN starting_at AND ending_at) ").any?
      errors.add(:vehicle_id, "vehicle can't overlap older trip of same vehicle in same time")
    elsif Trip.where.not(id: self.id).where(vehicle_id: self.vehicle_id).where(" (starting_at BETWEEN '#{self.starting_at}' AND '#{self.ending_at}') OR (ending_at BETWEEN '#{self.starting_at}' AND '#{self.ending_at}') ").any?
      errors.add(:vehicle_id, "vehicle can't overlap older trip of same vehicle in same time")
    end
  end

end
