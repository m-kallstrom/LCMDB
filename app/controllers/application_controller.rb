class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def admin_user
    @current_user == User.find_by(username: "Kristi")
  end
  helper_method :admin_user

end
