class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :sport
  belongs_to :event

   attr_accessible :cat1, :cat2 ,:cat3, :cat4, :cat5, :dif1, :dif2 ,:dif3, :dif4, :dif5, :sport_id, :user_id, :event_id, :comment, :rated_by
  
  
  def update_or_create(user)
    unless event_id.nil?
    @rating = Rating.find_or_create_by_user_id_and_rated_by_and_sport_id(user_id,user.id,sport_id)
    @stat = @rating.user.last_stat(sport_id)    
       @rating.update_attributes(:cat1 => ([1,@stat.cat1.ceil + dif1.to_i,10].sort[1]),:event_id => event_id,:dif1 => dif1)
       unless @stat.cat2.nil?
        @rating.update_attributes(:cat2 => ([1,@stat.cat2.ceil + dif2.to_i,10].sort[1]),:dif2 => dif2)
       end 
       unless @stat.cat3.nil?
        @rating.update_attributes(:cat3=> ([1,@stat.cat3.ceil + dif3.to_i,10].sort[1]),:dif3 => dif3)
       end 
       unless @stat.cat4.nil?
        @rating.update_attributes(:cat4 => ([1,@stat.cat4.ceil + dif4.to_i,10].sort[1]),:dif4 => dif4)
       end
       unless @stat.cat5.nil?
        @rating.update_attributes(:cat5 => ([1,@stat.cat5.ceil + dif5.to_i,10].sort[1]),:dif5 => dif5)
       end 
    else
       self.save
    end   
  end
  
  def comment=(comment)
    unless comment.blank?
      @feedback = Feedback.create(user_id: user_id, sport_id: sport_id, rated_by: rated_by, comment: comment)
      @feedback.save
    end
  end
  
  def comment
  end



end