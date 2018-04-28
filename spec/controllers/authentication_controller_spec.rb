require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let!(:company) { create :company }
  let!(:user) { create :user, company: company }

  it "signs in the user" do
    post :create, params: {
      user: {
        email: "#{user.email}",
        password: "#{user.password}"
      }
    }
    expect(response).to have_http_status(200)
  end

  it "validates for invalid email address" do
    post :create, params: {
      user: {
        email: "#{user.email}abc",
        password: "#{user.password}"
      }
    }
    expect(response).to have_http_status(401)
  end

  it "returns and error for wrong password" do
    post :create, params: {
      user: {
        email: "#{user.email}",
        password: "#{user.password}abc"
      }
    }
    expect(response).to have_http_status(401)
  end
end
