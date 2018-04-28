# == Schema Information
#
# Table name: vehicles
#
#  id                  :bigint(8)        not null, primary key
#  description         :text
#  registration_number :string
#  type                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  company_id          :bigint(8)
#
# Indexes
#
#  index_vehicles_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

require 'rails_helper'

RSpec.describe Vehicle, type: :model do

  it { should have_many(:trips) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:registration_number) }
  it { should validate_uniqueness_of(:registration_number) }

end
