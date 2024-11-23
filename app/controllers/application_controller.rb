class ApplicationController < ActionController::Base
  def home
    redirect_to "/dashboard"
	end
end
