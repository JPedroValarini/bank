class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Authentication
  helper_method :current_user
end
