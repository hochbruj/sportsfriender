class UserMailer < ActionMailer::Base
  default :from => "info@sportsfriender.com"

    def note(sender,recipient,message)
      @message = message
      @sender = sender
      @recipient = recipient
      mail(:to => @recipient.email, :subject => "Message from Sportsfriend #{@sender.full_name}")
    end
    
    def event_invite(recipient,email,event)
      @recipient = recipient
      @event = event
      mail(:to => email, :subject => "Invitation: #{event.start_at.in_time_zone(event.city.zone).strftime("%a %d/%m/%y %H:%M")} #{event.sport.name} at #{event.location.name}")
    end
    
    def event_cancel(user,event)
      @user = user
      @event = event
      mail(:to => user.email, :subject => "Cancelled: #{event.start_at.in_time_zone(event.city.zone).strftime("%a %d/%m/%y %H:%M")} #{event.sport.name} at #{event.location.name}")
    end

end
