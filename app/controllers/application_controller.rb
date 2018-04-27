class ApplicationController < ActionController::API

  def current_company
    @current_company = current_user&.company
  end

end
