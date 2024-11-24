class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def create
    user = User.find_by(email: params[:email])
    if user && user.password == params[:password]
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:error] = "Invalid email or password"
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/login"
  end
end
