class UsersController < ApplicationController
  # GET /users
  # GET /users.json

before_filter :authenticate_user!  

  def index
    @users = User.where("first_name ilike ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @title = 'Profile'
    @header = 'profile'
    @span = 'nomargin_10'
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = 'My Profile'
    @header = 'my_profile'
    @span = 'nomargin_10'
    
    @user = User.find(params[:id])
    if @user.profile_complete?
      @button_text = I18n.t('save')
     else
      @button_text = I18n.t('assess')
     end    
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @title = "My Profile"
    @header = 'my_profile'
    @span = 'nomargin_10'
    
    @user = User.find(params[:id])
     
     if @user.profile_complete?
      @button_text = I18n.t('goto_dash')
     else
      @button_text = I18n.t('pick_assess')
     end
    

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if @user.profile_complete?
        format.html { redirect_to dashboard_path }
        else
          format.html { redirect_to newsport_path}
        end
        
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
