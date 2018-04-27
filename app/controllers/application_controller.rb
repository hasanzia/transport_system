class ApplicationController < ActionController::API

  def authenticate_user
    unless current_user
      payload = {
        errors: "Please check parameters for authorization and try again. Provide either a authorization token or an email with password.",
        status: 401
      }
      render json: payload, status: 401 and return
    end
  end

  def authenticate_admin_user
    unless current_user.admin?
      payload = {
        errors: "This endpoint is only allowed by a user with admin privileges. Please login again with an admin user.",
        status: 401
      }
      render json: payload, status: 401 and return
    end
  end

  def current_user
    auth_token = params[:auth_token]
    if auth_token
      @current_user ||= User.find_by_authentication_token auth_token
    elsif params[:email].present && params[:password].present?
      user = User.find_by_email params[:email]
      @current_user ||= user if user.present? && user.valid_password?(params[:password])
    end
  end

  def current_company
    @current_company ||= current_user&.company
  end

end
