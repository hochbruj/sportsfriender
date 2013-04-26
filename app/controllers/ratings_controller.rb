class RatingsController < ApplicationController

  def new
    @header = 'My Sports'
    @rating = Rating.new
    @lhn = 'my_sports'
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
    @rating = Rating.new(params[:rating])
    @rating.user = current_user
    @rating.rated_by = current_user.id
     respond_to do |format|
        if @rating.save
           @rating.user.new_stat(@rating.sport_id)
          format.html { redirect_to newsport_path }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
   
  end  
  
  
  
  
  
    
end