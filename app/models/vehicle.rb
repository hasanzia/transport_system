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

class Vehicle < ApplicationRecord

  self.inheritance_column = :_type_disabled

  has_many :trips

  belongs_to :company

  validates :registration_number, presence: true, uniqueness: true

  enum type: [:truck]

end
