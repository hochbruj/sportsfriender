class UserMailer < ActionMailer::Base
  default :from => "info@skillupsport.com"

    def note(sender,recipient,message)
      @message = message
      @sender = sender
      @recipient = recipient
      mail(:to => @recipient.email, :subject => "Message from #{@sender.full_name}")
    end
    
    def event_invite(recipient,email,event)
      @recipient = recipient
      @event = event
      mail(:to => email, :subject => "Invitation: #{event.sport.name} #{t(event.mode)}")
    end
    
    def event_cancel(user,event)
      @user = user
      @event = event
      mail(:to => user.email, :subject => "Cancelled: #{event.sport.name} #{t(event.mode)}")
    end

end
