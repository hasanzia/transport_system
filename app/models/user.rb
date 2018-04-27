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

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :trips

  belongs_to :company

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: [:admin, :user]

  after_initialize :set_default_role, unless: :role?
  after_create :set_authentication_token

  def set_default_role
    update_attribute(:role, User.roles[:user])
  end

  def set_authentication_token
    update_attribute(:authentication_token, Devise.friendly_token)
  end

end
