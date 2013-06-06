class GroupsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @group.user_id = current_user.id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
   respond_to do |format| 
    if current_user.groups.empty? or Group.valid_for(current_user,User.find(params[:user_id])).empty?
    @group = Group.new
    @group.name = params[:new_group_name]
    @group.user_id = current_user.id
     if @group.save
        @member = @group.members.create(user_id: params[:user_id])
        format.html { redirect_to mysportsfriends_path }
     else
        format.html { redirect_to :back, alert: I18n.t('group_error') }
     end
    else
     if params[:new_group] == '1'
       @group = Group.new
       @group.name = params[:group_name]
       @group.user_id = current_user.id
       if @group.save
         @member = @group.members.create(user_id: params[:user_id])
         format.html { redirect_to mysportsfriends_path }
       else
        format.html { redirect_to :back, alert: I18n.t('group_error') }
       end
     else
       @group = Group.find(params[:group_id])
       @member = @group.members.create(user_id: params[:user_id])
       format.html { redirect_to mysportsfriends_path }
     end
    end       
   end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
