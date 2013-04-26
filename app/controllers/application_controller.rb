class ApplicationController < ActionController::Base
  before_filter :set_locale
  def set_locale
      I18n.locale = params[:locale]
  end

  protect_from_forgery

    def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
    end


  def after_sign_in_path_for(user)
   stored_location_for(resource) || welcome_path
  end
  
  
end
