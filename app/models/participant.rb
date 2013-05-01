class Participant < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :event_id, :organizer, :rated, :user_id
end
