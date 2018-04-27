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

FactoryBot.define do
  factory :vehicle do
    registration_number "MyString"
    type 1
    description "MyText"
    company nil
  end
end
