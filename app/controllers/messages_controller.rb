class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def new

    @message = Message.new
    @message.content = params[:content]
    @message.sender_id = current_user.id
    @message.recipient_id = params[:recipient]
    respond_to do |format|
      @message.send_it
      @message.save!   
      format.html { redirect_to :back, notice: I18n.t('message_sent_success')  }
    end
  end  
   
  
end  
  
