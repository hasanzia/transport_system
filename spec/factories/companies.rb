# == Schema Information
#
# Table name: companies
#
#  id         :bigint(8)        not null, primary key
#  address    :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
  end
end
