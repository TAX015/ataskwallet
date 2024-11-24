class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:home]
  include ActionController::Cookies

  def home
    if current_user
      redirect_to dashboard_path
    else
      redirect_to login_path
    end
	end

  private
  def current_user
    @current_user ||= (User.find(session[:user_id]) rescue nil) if session[:user_id]
  end

  def authenticate_user
    return if controller_name == "sessions" && action_name == "new"
    redirect_to "/login" unless current_user
  end
end
