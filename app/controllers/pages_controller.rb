class PagesController < ApplicationController
 before_filter :authenticate_user!,
  :only => [:dashboard, :myevents, :feedback, :mysports, :myprogress, :mysportsfriends] 
  
  require 'will_paginate/array'
  
      
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
 
  
  def dashboard
    if current_user.profile_complete?
    @title = "Dashboard"
    @header = 'dashboard'
    @lhn = 'dashboard'
    @span = 'nomargin_10'
    
    @user = current_user
    @last = current_user.completed_events.first
    @upcoming = current_user.events.where("finish_at > ?",DateTime.now).where(:cancelled => nil).order('start_at ASC').group_by { |event| event.start_at.to_date } 
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
    @upcoming = current_user.events.where("finish_at > ?",DateTime.now).where(:cancelled => nil)
    .order('start_at ASC').group_by { |event| event.start_at.to_date }
    @completed = current_user.completed_events.group_by { |event| event.start_at.to_date }
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
  
  def mysportsfriends
    @title = "My Sportsfriendss"
    @header = 'my_sportsfriends'
    @lhn = 'my_sportsfriends'
    @span = 'nomargin_10'
    

    @users = User.search(params[:sport_id],params[:lat],params[:lng])
    @users = @users.paginate(:page => params[:page], :per_page => 5) unless @users.nil?
    @sport = Sport.find(params[:sport_id]) unless params[:sport_id].nil?
    
  end

  def contact
    @title = "Contact"
    @header = 'contact'
    @no_lhn = true
    @span = 'span_12'
  end
  
  def about
    @title = "About"
    @header = 'about'
    @no_lhn = true
    @span = 'span_12'
  end
    
end
