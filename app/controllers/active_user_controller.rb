class ActiveUserController < ApplicationController
  def home
   @active_user_id = session[:user_id]
   session[:show_hide] = false 
   session[:show_hide_results] = false 
   if @active_user_id 
     @active_user_name = User.find(@active_user_id).username
     @fan_requests = FanRequest.where('owner_id = ' + @active_user_id.to_s + ' or user_id = ' + @active_user_id.to_s)

     @fans = Fan.where('owner_id = ' + @active_user_id.to_s)
     @fan_messages = Array.new
     @fan_questions = Array.new
     @fan_polls = Array.new
     @count = 0
     @fans.each do |fan|
       break if @count == 50

       @fan_message_type = FanMessageType.where('fan_id = ' + fan.user_id.to_s)
       if @fan_message_type && !@fan_message_type.empty?
            if @fan_message_type.first.message_type == 1
		@fan_message = FanMessage.where('owner_id = ' + fan.user_id.to_s)
       		if @fan_message && !@fan_message.empty?
          	  @fan_messages << @fan_message.first 
       		end
            elsif @fan_message_type.first.message_type == 2
	       @fan_question = FanQuestion.where('owner_id = ' + fan.user_id.to_s)
       		if @fan_question && !@fan_question.empty? 
          	  @fan_questions << @fan_question.first 
       		end
  	    elsif @fan_message_type.first.message_type == 3
	       @fan_poll = FanPoll.where('owner_id = ' + fan.user_id.to_s)
       		if @fan_poll && !@fan_poll.empty? 
          	  @fan_polls << @fan_poll.first 
       		end
            end
       end

       @count = @count + 1
     end

   @events = ChatEvent.all
   @event_msg = "" 
   @requesting_user = nil 

     @events.each do |event|
      if (event && event.owner_id && event.target_id && event.target_id == @active_user_id)  	 
    	   @requesting_user = User.find(event.owner_id)
  	   if (@requesting_user != nil)
             @event_msg = @requesting_user.username + " wants to chat"
	     # event has been handled. Delete.
	     event.delete  
  	   end
        end
      end
    end

    respond_to do |format|
       format.js { render 'event_update' }
       format.html 
    end
  end

  def submit_fan_vote 
    @poll_id = params[:poll_id]
    @poll_owner_id = params[:poll_owner_id]

    @active_user_id = session[:user_id]
    @responded = FanResponded.new
    @responded.fan_id = @active_user_id
    @responded.responded_to = @poll_owner_id
    @responded.save

    1.upto(5).each do |i|
      @option = params["option_" + i.to_s]
      if @option && !@option.empty?
        if @poll_id && !@poll_id.empty?
 	  @poll = FanPoll.where("id = " + @poll_id)
 	  if i == 1
	    if @poll.first.option_1 == nil
	      @poll.first.option_1 = 1
            else
  	      @poll.first.option_1 = @poll.first.option_1 + 1
 	    end
	  elsif i == 2
	    if @poll.first.option_2 == nil
	      @poll.first.option_2 = 1
            else
  	      @poll.first.option_2 = @poll.first.option_2 + 1
 	    end
	  elsif i == 3
	    if @poll.first.option_3 == nil
	      @poll.first.option_3 = 1
            else
  	      @poll.first.option_3 = @poll.first.option_3 + 1
 	    end
	  elsif i == 4
  	    if @poll.first.option_4 == nil
	      @poll.first.option_4 = 1
            else
  	      @poll.first.option_4 = @poll.first.option_4 + 1
 	    end
	  elsif i == 5
	    if @poll.first.option_5 == nil
	      @poll.first.option_5 = 1
            else
  	      @poll.first.option_5 = @poll.first.option_5 + 1
 	    end
	  end
	  @poll.first.save
       end
      end
    end
   redirect_to active_user_home_url  
  end

  def respond_to_fan
   @response_text = params[:response]
   @response = FanResponse.new
   @response.response = @response_text
   @response.question_id = params[:response_id] 
   @response.fan_id = session[:user_id] 
   @response.save

   redirect_to active_user_home_url  
  end

  def respond_to_question 
   @active_user_id = session[:user_id]
   @question_id = params[:question_id]
   respond_to do |format|
     format.js
   end 
  end 

  def fan_vote 
   @active_user_id = session[:user_id]
   @poll_id = params[:poll_id]
   respond_to do |format|
     format.js
   end 
  end 

  def show_hide_responses 
   @active_user_id = session[:user_id]
   session[:show_hide_responses] = !session[:show_hide_responses] 
   @fan_responses = FanResponse.where('question_id = ' + @active_user_id.to_s)
   respond_to do |format|
     format.js
   end 
  end 

  def show_hide_results
   @active_user_id = session[:user_id]
   session[:show_hide_results] = !session[:show_hide_results] 
   @fan_polls = FanPoll.where('owner_id = ' + @active_user_id.to_s)
   @fan_poll_options = nil

   @percentage1 = 0  
   @percentage2 = 0  
   @percentage3 = 0  
   @percentage4 = 0 
   @percentage5 = 0  

   if @fan_polls && !@fan_polls.empty? 
  	if @fan_polls.first.option_1 == nil
	  @option1 = 0 
  	else
	  @option1 = @fan_polls.first.option_1
        end

  	if @fan_polls.first.option_2 == nil
	  @option2 = 0 
  	else
	  @option2 = @fan_polls.first.option_2
        end

  	if @fan_polls.first.option_3 == nil
	  @option3 = 0 
  	else
	  @option3 = @fan_polls.first.option_3
        end

  	if @fan_polls.first.option_4 == nil
	  @option4 = 0 
  	else
	  @option4 = @fan_polls.first.option_4
        end

  	if @fan_polls.first.option_5 == nil
	  @option5 = 0 
  	else
	  @option5 = @fan_polls.first.option_5
        end

	@sum = @option1 + @option2 + @option3 + @option4 + @option5

	if @sum != 0  
          @percentage1 = (@option1/@sum).round
          @percentage2 = (@option2/@sum).round
          @percentage3 = (@option3/@sum).round
          @percentage4 = (@option4/@sum).round
          @percentage5 = (@option5/@sum).round
	end

     @fan_poll_options = FanPollOption.where('poll_id = ' + @fan_polls.first.id.to_s)

   end

   respond_to do |format|
     format.js
   end 
  end

  def show_hide_requests 
   @active_user_id = session[:user_id]
   session[:show_hide] = !session[:show_hide] 
   @fan_requests = FanRequest.where('owner_id = ' + @active_user_id.to_s + ' or user_id = ' + @active_user_id.to_s)
   respond_to do |format|
     format.js
   end 
  end 

  def accept_fan 
    @new_fan_id = params[:param]

    @fan = Fan.where('owner_id = ' + session[:user_id].to_s + ' and user_id = ' + @new_fan_id.to_s)
    
    #no duplicate fans
    if @fan && @fan.empty?
    	@new_fan = Fan.new
    	@new_fan.owner_id = session[:user_id]
    	@new_fan.user_id = @new_fan_id
    	@new_fan.save
    end
 
    @req = FanRequest.where('owner_id = ' + @new_fan_id.to_s)

    if @req && @req[0] 
      FanRequest.delete(@req[0].id)
    end

    respond_to do |format|
     format.html { redirect_to active_user_home_url }
    end
  end

  def ignore_fan
  end

  def poll_fans 
    @poll_question = params[:poll_question]
    @number_options = params[:num_options] 

    @active_user_id = session[:user_id]

    @poll = FanPoll.new	
    @poll.question = @poll_question
    @poll.owner_id = session[:user_id] 
    @poll.save

    if @number_options == "1"
       @option1 = FanPollOption.new	
       @option1.option = params[:option_1] 
       @option1.poll_id = @poll.id 
       @option1.save
    elsif @number_options == "2"
       @option1 = FanPollOption.new	
       @option1.option = params[:option_1] 
       @option1.poll_id = @poll.id 
       @option1.save

       @option2 = FanPollOption.new	
       @option2.option = params[:option_2] 
       @option2.poll_id = @poll.id 
       @option2.save
    elsif @number_options == "3"
       @option1 = FanPollOption.new	
       @option1.option = params[:option_1] 
       @option1.poll_id = @poll.id 
       @option1.save

       @option2 = FanPollOption.new	
       @option2.option = params[:option_2] 
       @option2.poll_id = @poll.id 
       @option2.save

       @option3 = FanPollOption.new	
       @option3.option = params[:option_3] 
       @option3.poll_id = @poll.id 
       @option3.save
    elsif @number_options == "4"
       @option1 = FanPollOption.new	
       @option1.option = params[:option_1] 
       @option1.poll_id = @poll.id 
       @option1.save

       @option2 = FanPollOption.new	
       @option2.option = params[:option_2] 
       @option2.poll_id = @poll.id 
       @option2.save

       @option3 = FanPollOption.new	
       @option3.option = params[:option_3] 
       @option3.poll_id = @poll.id 
       @option3.save

       @option4 = FanPollOption.new	
       @option4.option = params[:option_4] 
       @option4.poll_id = @poll.id 
       @option4.save
    elsif @number_options == "5"
       @option1 = FanPollOption.new	
       @option1.option = params[:option_1] 
       @option1.poll_id = @poll.id 
       @option1.save

       @option2 = FanPollOption.new	
       @option2.option = params[:option_2] 
       @option2.poll_id = @poll.id 
       @option2.save

       @option3 = FanPollOption.new	
       @option3.option = params[:option_3] 
       @option3.poll_id = @poll.id 
       @option3.save

       @option4 = FanPollOption.new	
       @option4.option = params[:option_4] 
       @option4.poll_id = @poll.id 
       @option4.save

       @option5 = FanPollOption.new	
       @option5.option = params[:option_5] 
       @option5.poll_id = @poll.id 
       @option5.save
    end

      @fan_message_type = FanMessageType.where('fan_id = ' + session[:user_id].to_s)
      if @fan_message_type && !@fan_message_type.empty?
	@fan_message_type.first.message_type = 3 
        @fan_message_type.first.save
      else
        @new_type = FanMessageType.new
        @new_type.message_type = 3 
        @new_type.fan_id = session[:user_id]
        @new_type.save
      end

      clear_responses(@active_user_id)

      session[:current_update_type] = 3 
      session[:current_update] = @poll_question  
        
    redirect_to active_user_home_url  
  end

  def ask_fan_question 
    if session[:user_id] && params[:question]
      @fan_question = FanQuestion.where('owner_id = ' + session[:user_id].to_s)
      if @fan_question && !@fan_question.empty?
         @fan_question.first.question = params[:question]
         @fan_question.first.save
      else 
         @new_question = FanQuestion.new
         @new_question.question = params[:question]
         @new_question.owner_id = session[:user_id]
         @new_question.save
      end 

      @fan_message_type = FanMessageType.where('fan_id = ' + session[:user_id].to_s)
      if @fan_message_type && !@fan_message_type.empty?
	@fan_message_type.first.message_type = 2 
        @fan_message_type.first.save
      else
        @new_type = FanMessageType.new
        @new_type.message_type = 2 
        @new_type.fan_id = session[:user_id]
        @new_type.save
      end

      clear_responses(@active_user_id)

      session[:current_update] = params[:question]
      session[:current_update_type] = 2 

      redirect_to active_user_home_url  
    end
  end

  def send_fan_message
    if session[:user_id] && params[:message]
      @fan_message = FanMessage.where('owner_id = ' + session[:user_id].to_s)
      if @fan_message && !@fan_message.empty?
         @fan_message.first.message = params[:message]
         @fan_message.first.save
      else 
         @new_message = FanMessage.new
         @new_message.message = params[:message]
         @new_message.owner_id = session[:user_id]
         @new_message.save
      end 
      
      @fan_message_type = FanMessageType.where('fan_id = ' + session[:user_id].to_s)
      if @fan_message_type && !@fan_message_type.empty?
	@fan_message_type.first.message_type = 1
        @fan_message_type.first.save
      else
        @new_type = FanMessageType.new
        @new_type.message_type = 1 
        @new_type.fan_id = session[:user_id]
        @new_type.save
      end

      session[:current_update] = params[:message]
      session[:current_update_type] = 1 

      redirect_to active_user_home_url  
    end
  end

  def load_updates
    if params[:count] 
       @count = params[:count].to_i
       @count = @count + 1
       @fan_messages = FanMessage.where('owner_id > ' + @count.to_s + ' and owner_id < ' + (@count + 50).to_s)
    end

    respond_to do |format|
      format.js
    end
  end

   def delete_fan
    if params[:fan_id] && session[:user_id]
      @fan_id = params[:fan_id]
      @fans = Fan.where('user_id = ' + @fan_id.to_s + ' and owner_id = ' +  session[:user_id].to_s)
      if @fans.length > 0 
         Fan.delete(@fans[0].id)
      end
    end

    respond_to do |format|
     format.js { render 'fan_update' } 
    end
  end

  def logout
    session[:user_id] = nil
    session[:current_update] = nil
    session[:show_hide] = nil
    redirect_to say_hello_url, notice: "Logged out"
  end

private
  def clear_responses(current_user) 
    if current_user 
      @fans_responded = FanResponded.where('responded_to = ' +  current_user.to_s)
      if @fans_responded && !@fans_responded.empty?
       @fans_responded.each do |response|
         FanResponded.delete(response.id)
        end 
      end
    end
  end
end