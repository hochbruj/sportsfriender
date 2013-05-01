class PagesController < ApplicationController
  def home
    if params[:set_locale]
    redirect_to root_path(:locale => params[:set_locale])
    else
    @title = "Home"
    end
    
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
  
  def dashboard
    if current_user.profile_complete?
    @header = 'Dashboard'
    @lhn = 'dashboard'
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
  
end
