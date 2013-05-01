class EventsController < ApplicationController
 
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @header = 'My Events'
    @lhn = 'my_events'
    @event = Event.find(params[:id])
    @location = Location.find(@event.location_id).to_gmaps4rails do |location, marker|
    marker.infowindow render_to_string(:partial => "/markers/show_way", :locals => { :object => location })
    end
    @post_items = @event.event_posts.paginate(:page => params[:page], :per_page => 2).order('created_at desc')
    
    session[:event_id] = @event.id
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @header = 'My Events'
    @lhn = 'my_events'
   
   @event = Event.new
   #set sport
     if params[:sport_id]
      @event.sport = Sport.find(params[:sport_id])
     else
      @event.sport = current_user.sport
     end

  #set city
     if params[:event_city]
      @event.city = City.find_by_full_name(params[:event_city])
     else
      @event.city = current_user.city
     end
   
  #set location
     if params[:location_id]
      @event.location = Location.find(params[:location_id])
     end
        
    
  #set Time
    @event.start_at = DateTime.now

    respond_to do |format|
      if @event.city.nil?
      format.html { redirect_to :back, alert: "Please enter a valid city" }
      else
      format.html # new.html.erb
      format.json { render json: @event }
      end
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @header = 'My Events'
    @lhn = 'my_events'
    @event = Event.new(params[:event])
    @event.set_time

    respond_to do |format|
      if @event.save_set_organizer(current_user)
        format.html { redirect_to dashboard_path, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
