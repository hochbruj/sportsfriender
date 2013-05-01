class ParticipantsController < ApplicationController

  def create
   @event = Event.find(params[:participant][:event_id])
   @participant = Participant.new(params[:participant])
   @participant.user = current_user
   @participant.event = @event
   
    respond_to do |format|
      if @participant.save!
        format.html { redirect_to dashboard_path }
      else
        format.html { redirect_to @event }
      end
    end
  end  
  
  def destroy
     @participant = Participant.find(params[:id])
     @participant.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path }
    end
  end
  
  
  
  
  
end