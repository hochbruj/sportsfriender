class SportsController < ApplicationController

 before_filter :require_admin
  
def new
  @title = 'My Sports'
  @header = 'my_sports'
  @lhn = 'sports'
  @span = 'nomargin_10'
  
  @sport = Sport.new
  2.times { @sport.assessments.build}
  
end

def create
  @title = 'My Sports'
  @header = 'my_sports'
  @lhn = 'ports'
  @span = 'nomargin_10'
  
  @sport = Sport.new(params[:sport])
  
    if @sport.save
       10.times { |i| @sport.assessments.create(level:(i + 1)) }
       redirect_to sports_path, notice: "New Sport successfully created!" 
    else
       redirect_to @sport, alert: I18n.t('post_error')
    end

end

def edit
  @title = 'My Sports'
  @header = 'my_sports'
  @lhn = 'sports'
  @span = 'nomargin_10'
   @sport = Sport.find(params[:id])
 end

 def update
   @sport = Sport.find(params[:id])
   if @sport.update_attributes(params[:sport])
     redirect_to sports_path, :notice  => "Sport successfully updated!"
   else
     render :action => 'edit'
   end
 end
  
  
  

def index
  @title = 'My Sports'
  @header = 'my_sports'
  @lhn = 'my_sports'
  @span = 'nomargin_10'
  @sports = Sport.all

end
 
  
end