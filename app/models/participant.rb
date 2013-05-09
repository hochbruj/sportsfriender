class Participant < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :event_id, :organizer, :rated, :user_id
  
  def unrated?(user)
  Rating.where(:user_id => user_id, :rated_by => user.id, :event_id => event_id).first.nil?
  end
  
  def rating(user)
  Rating.where(:user_id => user_id, :rated_by => user.id, :event_id => event_id).first
  end
  
end
