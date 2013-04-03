class Sport < ActiveRecord::Base
  translates :name, :cat1, :cat2, :cat3, :cat4, :cat5
  attr_accessible :name, :cat1, :cat2, :cat3, :cat4, :cat5
  
  has_many :assessments
  
  def catcount
  count = 0
   unless self.cat1 == 'nil'
   count +=1
   end
   unless self.cat2 == 'nil'
   count +=1
   end
   unless self.cat3 == 'nil'
   count +=1
   end
   unless self.cat4 == 'nil'
   count +=1
   end
   unless self.cat5 == 'nil' 
   count +=1
   end
  return count
  end




end
