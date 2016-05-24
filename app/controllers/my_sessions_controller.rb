class MySessionsController < Devise::SessionsController

def new
 @title = "TEST"
 @header = 'login'
 @span = 'login_window'
 super
end
end
