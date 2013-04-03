class Assessment < ActiveRecord::Base
  translates :cat1, :cat2, :cat3, :cat4, :cat5
  attr_accessible :cat1, :cat2, :cat3, :cat4, :cat5, :level, :sport_id
  
  belongs_to :sport
end
