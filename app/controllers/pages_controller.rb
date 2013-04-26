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
  
  
  
end
