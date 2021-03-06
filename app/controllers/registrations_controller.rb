class RegistrationsController < Devise::RegistrationsController
  def new
    @title = I18n.t('signup')
    @header = 'signup'
    @span = 'login_window'
    
    super
  end
  
  def create
     @title = I18n.t('signup')
     @header = 'signup'
     @span = 'login_window'
     super
   end
  
  protected

  def after_sign_up_path_for(resource)
    welcome_path
  end
end