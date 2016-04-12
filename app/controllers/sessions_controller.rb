class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
 	session[:user_id] = user.id
	redirect_to active_user_home_url
    else
	redirect_to say_hello_url, alert: "Invalid username and/or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to say_hello_url, notice: "Logged out"
  end
end
