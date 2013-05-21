class RegistrationsController < Devise::RegistrationsController
  def new
    @title = "Sign up"
    @header = 'signup'
    @span = 'span4 offset4'
    
    super
  end
  
  def create
     @title = "Sign up"
     @header = 'signup'
     @span = 'span4 offset4'
     super
   end
  
  protected

  def after_sign_up_path_for(resource)
    welcome_path
  end
end