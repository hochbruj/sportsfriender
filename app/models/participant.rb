class Participant < ActiveRecord::Base
  attr_accessible :event_id, :organizer, :rated, :user_id
end
