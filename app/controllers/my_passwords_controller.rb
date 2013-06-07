class MyPasswordsController < Devise::PasswordsController

def new
 @title = "Forgot Password"
 @header = 'forgot_password'
 @span = 'span12'
 super
end

def create
 @title = "Forgot Password"
 @header = 'forgot_password'
 @span = 'span12'
 super
end

def edit
 @title = "Change Password"
 @header = 'change_password'
 @span = 'span12'
 super
end
end
