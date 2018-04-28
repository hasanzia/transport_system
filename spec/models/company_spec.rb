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

require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_many(:users) }
  it { should have_many(:trips) }
  it { should have_many(:vehicles) }
end
