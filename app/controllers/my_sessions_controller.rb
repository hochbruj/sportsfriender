class MySessionsController < Devise::SessionsController

def new
 @title = I18n.t('login')
 @header = 'login'
 @span = 'span4 offset4'
 super
end
end
