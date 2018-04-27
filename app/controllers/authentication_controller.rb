class AuthenticationController < ApplicationController

  def create
    @user = User.find_by(email: authentication_params[:email])
    if @user.present? && @user.valid_password?(authentication_params[:password])
      @user.set_authentication_token
      render json: { user: @user }
    else
      payload = {
        errors: "Please check parameters for authorization and try again. You provided an incorrect email with password combination.",
        status: 401
      }
      render json: payload, status: 401
    end
  end

  private

    def authentication_params
      params.require(:user).permit(:email, :password)
    end

end
