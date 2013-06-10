class MySessionsController < Devise::SessionsController

def new
 @title = I18n.t('login')
 @header = 'login'
 @span = 'span5 offset3'
 super
end
end
