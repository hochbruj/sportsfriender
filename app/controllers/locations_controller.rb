class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @title = 'My Events'
    @header = 'my_events'
    @lhn = 'my_events'
    @span = 'nomargin_10' 
    @location = Location.new
    @location.sport_id = params[:sport_id]
    @location.city_id = params[:city_id]
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @header = 'my_events'
    @lhn = 'my_events'
    @span = 'nomargin_10' 
    @location = Location.new(params[:location])
    @location.user = current_user
    respond_to do |format|
      if @location.save
        format.html { redirect_to new_event_path(:sport_id => @location.sport_id, :event_city => @location.city.full_name, :location_id => @location.id) } 
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
  
  def map
    @title = 'My Events'
    @header = 'my_events'
    @lhn = 'my_events'
    @span = 'nomargin_10'
    @location = Location.where(city_id: params[:city_id], sport_id: params[:sport_id]).to_gmaps4rails do |location, marker|
      marker.infowindow render_to_string(:partial => "/markers/select_city", :locals => { :object => location })
      end
  end
  
end