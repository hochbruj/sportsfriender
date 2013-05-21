class RatingsController < ApplicationController

  def new
    @title = 'My Sports'
    @header = 'my_sports'
    @rating = Rating.new
    @lhn = 'my_sports'
    @span = 'nomargin_10'
    unless current_user.profile_complete?
    @sport = current_user.sport
    else
     if params[:sport_id]
     @sport = Sport.find(params[:sport_id])
     else
     @sport = current_user.not_rated.first
     end
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rating }
    end
  end  
  
  def create
    @title = 'My Sports'
    @header = 'my_sports'
    @lhn = 'my_sports'
    @span = 'nomargin_10'
    
    @rating = Rating.new(params[:rating])
    @rating.rated_by = current_user.id
     respond_to do |format|
           @rating.update_or_create(current_user)
           @rating.user.new_stat(@rating.sport_id)
         if @rating.event_id.nil?  
          format.html { redirect_to mysports_path }
        else
          format.html { redirect_to :back }
        end
      end
   
  end  
  
  
  
  
  
    
end