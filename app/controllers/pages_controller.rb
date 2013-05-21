class PagesController < ApplicationController
  def home
    if params[:set_locale]
     if signed_in?
     redirect_to dashboard_path(:locale => params[:set_locale])
     else
     redirect_to root_path(:locale => params[:set_locale])
     end
    else
      if signed_in?
      redirect_to dashboard_path
      end
    @title = "Home"
    @span = 'span12'
    @no_lhn = true
    end
    
  end


  def contact
    @title = "Contact"
    @span = 'span12'
  end

 
  
  def dashboard
    if current_user.profile_complete?
    @title = "Dashboard"
    @header = 'dashboard'
    @lhn = 'dashboard'
    @span = 'nomargin_10'
    
    @user = current_user
    @last = current_user.completed_events.first
    @upcoming = current_user.events.where("finish_at > ?", 
    DateTime.now).order('start_at ASC').group_by { |event| event.start_at.in_time_zone(event.city.zone).to_date } 
     unless @upcoming.empty?
      if @upcoming.to_a[0][1].count > 1
         @upcoming = @upcoming.first(1)
      else
        @upcoming = @upcoming.first(2)
      end
     end
   else
     redirect_to welcome_path
   end
  
  end
  
  def myevents
    @title = "My Events"
    @header = 'my_events'
    @lhn = 'my_events'
    @span = 'nomargin_10'
    
    @tab1 = 'active' unless params[:active] == 'tab2'
    @tab2 = 'active' if params[:active] == 'tab2'
    @upcoming = current_user.events.where("finish_at > ?", 
    DateTime.now).order('start_at ASC').group_by { |event| event.start_at.in_time_zone(event.city.zone).to_date }
    @completed = current_user.completed_events.group_by { |event| event.start_at.in_time_zone(event.city.zone).to_date }
  end
  
  def feedback
    @title = "Feedback"
    @header = 'my_events'
    @lhn = 'my_events'
    @span = 'nomargin_10'
    
    @event = Event.find(params[:event_id])
    @rating = @rating = Rating.new
  
  end
  
  def mysports
    @title = "My Sports"
    @header = 'my_sports'
    @lhn = 'my_sports'
    @span = 'nomargin_10'
    
  end
  
  def myprogress
    @title = "My Progress"
    @header = 'my_progress'
    @lhn = 'my_progress'
    @span = 'nomargin_10'
    
  end
  
  def pointer
    @pointer = current_user.pointers.build(:cat_id => params[:cat_id])
    @pointer.save
    redirect_to :back
  end
  
  def privacy
    @title = "Privacy"
    @header = 'privacy'
    @no_lhn = true
    @span = 'span_12'
  
  end
  
  def welcome
    @title = "Welcome"
    @header = 'welcome'
    @span = 'nomargin_10'
  
  end
  
end
