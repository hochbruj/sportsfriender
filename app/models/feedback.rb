class Feedback < ActiveRecord::Base
  attr_accessible :comment, :rated_by, :sport_id, :user_id
  
end
