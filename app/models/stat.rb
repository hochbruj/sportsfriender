class Stat < ActiveRecord::Base
  attr_accessible :cat1, :cat2, :cat3, :cat4, :cat5, :sport_id, :user_id
  
  belongs_to :sport
  belongs_to :user
  
  def total_skill
  unless self.cat1.nil?
    total = self.cat1
  end
  unless self.cat2.nil?
    total += self.cat2
  end
  unless self.cat3.nil?
    total += self.cat3
  end
  unless self.cat4.nil?
    total += self.cat4
  end
  unless self.cat5.nil?
    total += self.cat5
  end
  total = total / self.sport.catcount
  end
  

end
