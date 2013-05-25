class Message < ActiveRecord::Base
  attr_accessible :content, :recipient_id, :sender_id
  
  def send_it
    UserMailer.note(User.find(sender_id),User.find(recipient_id),self).deliver    
  end

end
