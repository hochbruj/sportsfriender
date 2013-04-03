class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :sport

   attr_accessible :cat1, :cat2 ,:cat3, :cat4, :cat5, :sport_id
  
  
  def update_or_create(user)
    unless play_id.nil?
    @rating = Rating.find_or_create_by_user_id_and_rated_by_and_sport_id(user_id,user.id,sport_id)
    @stat = @rating.user.last_stat(sport_id)    
       @rating.update_attributes(:cat1 => ([1,@stat.cat1.ceil + diff1.to_i,10].sort[1]),:play_id => play_id)
       unless @stat.cat2.nil?
        @rating.update_attributes(:cat2 => ([1,@stat.cat2.ceil + diff2.to_i,10].sort[1]))
       end 
       unless @stat.cat3.nil?
        @rating.update_attributes(:cat3=> ([1,@stat.cat3.ceil + diff3.to_i,10].sort[1]))
       end 
       unless @stat.cat4.nil?
        @rating.update_attributes(:cat4 => ([1,@stat.cat4.ceil + diff4.to_i,10].sort[1]))
       end
       unless @stat.cat5.nil?
        @rating.update_attributes(:cat5 => ([1,@stat.cat5.ceil + diff5.to_i,10].sort[1]))
       end 
    else
       self.save
    end   
  end

end