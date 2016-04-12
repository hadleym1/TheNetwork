class SayController < ApplicationController
  before_filter :check_mobile_device, :only => [:hello] 

  def hello
   @total_users = User.count
   @login_user = User.new
   @signup_user = User.new
  end

  def login
    @total_users = User.count
    @login_user = User.new(user_params)
    @signup_user = User.new

    user = User.find_by(username: @login_user.username)
    respond_to do |format|
      if user and user.authenticate(@login_user.password) 
	session[:user_id] = user.id
        format.html { redirect_to active_user_home_path, notice: 'Login Successful.' }
        #format.json { render :show, status: :created, location: @login_user }
      else
        format.html { redirect_to say_hello_path, alert: "Invalid Username and/or Password" }
        format.json { render json: @login_user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def signup
    @total_users = User.count
    @signup_user = User.new(user_params)
    @login_user = User.new

    respond_to do |format|
      if @signup_user.save
        format.html { redirect_to active_user_home_path, notice: 'User was successfully created.' }
      #  format.json { render :show, status: :created, location: @signup_user }
      else
        format.html { render :hello }
        format.json { render json: @signup_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def goodbye
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
