class AssessmentsController < ApplicationController

before_filter :require_admin  

def edit
  @title = 'My Sports'
  @header = 'my_sports'
  @lhn = 'sports'
  @span = 'nomargin_10'
  @assessment = Assessment.find(params[:id])
  @sport = @assessment.sport
 end

 def update
   @assessment = Assessment.find(params[:id])
   @sport = @assessment.sport
   if @assessment.update_attributes(params[:assessment])
     redirect_to edit_sport_path(@sport), :notice  => "Rating successfully updated!"
   else
     render :action => 'edit'
   end
 end
  
  

end