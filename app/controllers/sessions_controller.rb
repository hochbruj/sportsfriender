class SessionsController < ApplicationController

 
  def destroy
      session[:user_id] = nil
      redirect_to root_url
  end
    
  def failure
        redirect_to root_url, alert: "Authentication failed, please try again."
  end
end