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

class Company < ApplicationRecord
end
