class EventPost < ActiveRecord::Base
  attr_accessible :content, :event_id, :user_id
  
  belongs_to :event 
  belongs_to :user
  
  validates :content, :presence => true, :length   => { :maximum => 255 }
end
