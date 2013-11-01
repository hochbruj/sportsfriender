class MySessionsController < Devise::SessionsController

def new
 @title = I18n.t('login')
 @header = 'login'
 @span = 'login_window'
 super
end
end
