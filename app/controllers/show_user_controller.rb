class ShowUserController < ApplicationController
  def index
    if params[:id] != nil
      @user = User.find(params[:id])
      @join_date = @user.created_at.strftime("%B %d, %Y")
      @already_fan = false 
      @fans = Fan.where("user_id = " + session[:user_id].to_s + " and owner_id = " + params[:id].to_s)
      if @fans && !@fans.empty?
          @already_fan = true
      end
    end
  end

  def become_fan 
    if session != nil && session[:user_id] != nil
      @active_user_id = session[:user_id] 
      if params[:id] != nil
       @req = FanRequest.new
       @req.user_id = params[:id]
       @req.owner_id = @active_user_id
       @req.save
       respond_to do |format|
          format.html { redirect_to active_user_home_path, notice: 'Fan Request sent.' }
       end
      end
    else
      respond_to do |format|
          format.html { redirect_to active_user_home_path, notice: 'Fan Request sent.' }
      end
    end
  end
end
