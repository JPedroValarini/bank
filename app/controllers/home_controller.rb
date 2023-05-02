class HomeController < ApplicationController
  before_action :require_authentication

  def index
  end

  private

  def require_authentication
    redirect_to login_path unless current_user
  end

end
