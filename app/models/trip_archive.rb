# == Schema Information
#
# Table name: trip_archives
#
#  id                 :bigint(8)        not null, primary key
#  description        :text
#  distance_travelled :float
#  ending_at          :datetime
#  starting_at        :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :bigint(8)        not null
#  user_id            :bigint(8)        not null
#  vehicle_id         :bigint(8)        not null
#

class TripArchive < SecondBase::Base
end
