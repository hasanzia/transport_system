# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  address                :text
#  authentication_token   :string(30)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint(8)
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_company_id            (company_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:trips) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { should allow_value(*%w(user admin)).for :role }

  let!(:company) { create :company }
  let!(:user) { create :user, company: company }

  it "creates a normal user when no role is provided" do
    expect(user.role).to eq 'user'
  end

  it "creates the authentication_token when a User is created" do
    expect(user.authentication_token.present?).to be(true)
  end

end
