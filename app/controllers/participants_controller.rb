class ParticipantsController < ApplicationController
  before_filter :check_user



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
  
  private
  
  def check_user
   error = false
   @event = Event.find(params[:participant][:event_id])
   error = true unless (current_user.gender == @event.gender or @event.gender == 'mixed')
   error = true unless (current_user.last_stat(@event.sport_id).total_skill >= @event.skill_from)
   error = true unless (current_user.last_stat(@event.sport_id).total_skill <= @event.skill_to)
   error = true unless (current_user.age >= @event.age_from)
   error = true unless (current_user.age <= @event.age_to)
   if error == true
    respond_to do |format|
    flash[:error] = I18n.t('cant_signup')
    format.html { redirect_to :back }
    end
   end
  end
 
  
  
  
end