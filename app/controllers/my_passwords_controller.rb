class MyPasswordsController < Devise::PasswordsController

def new
 @title = "Forgot Password"
 @header = 'forgot_password'
 @span = 'span12'
 super
end
end
