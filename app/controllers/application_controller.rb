class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def check_mobile_device
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
     session[:mobile_device] = (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
  end
end
