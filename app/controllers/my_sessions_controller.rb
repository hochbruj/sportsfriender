class MySessionsController < Devise::SessionsController

def new
 @title = "Login"
 @header = 'login'
 @span = 'span4 offset4'
 super
end
end
