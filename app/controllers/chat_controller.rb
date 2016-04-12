class ChatController < ApplicationController
  skip_before_filter :verify_authenticity_token
  @@last_update = Time.now
  def update 
    @active_user_id = session[:user_id]
    @message = nil

    # this is a local message
    if (params[:message] != nil)
     @messageText = params[:message] 
     @message = ChatMessage.new
     @message.message = @messageText
     @message.sender_id = @active_user_id 
     
     if (params[:recipient] != nil)
	@recipient_name = params[:recipient]
        @users = User.where("username = '" + @recipient_name + "'")
	if (@users.length > 0)
         @message.recipient_id = @users[0].id 
	end
     end
     
     @message.save
    end 

    # remote messages
    @messages = ChatMessage.where("recipient_id = ? and created_at > ?", @active_user_id, @@last_update)
   
    if (@messages && @messages.length == 0)
      @messages = nil 
    else 
      logger.debug("FOUND " + @messages.length.to_s + " CHAT MESSAGES")
    end
    
    @@last_update = Time.now
    respond_to do |format|
       format.js { render 'update_messages' }
    end
  end

  def index
    @active_user_id = session[:user_id]

    if (params[:remote] != nil && params[:user] != nil)
       @recipient = params[:user]	
       @remote = params[:remote]
       @users = User.where("username = '" + @recipient + "'")
       if(@users.length > 0 && @remote == "true")        
         @recipient_id = @users[0].id

         @chat_event = ChatEvent.new
	 @chat_event.owner_id = session[:user_id]
	 @chat_event.target_id = @recipient_id
         @chat_event.save
       end

       @previous_messages = ChatMessage.where("recipient_id = ? or recipient_id = ?", @active_user_id, @recipient_id)
    end

    respond_to do |format|
       format.html { render layout: false, action: 'index' }
    end
  end
end
