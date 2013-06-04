class ParticipantsController < ApplicationController
  before_filter :check_user



  def create
   @event = Event.find(params[:participant][:event_id])
   @participant = Participant.new(params[:participant])
   @participant.user = current_user
   @participant.event = @event
   
    respond_to do |format|
      if @participant.save!
        format.html { redirect_to dashboard_path, notice: I18n.t('join_success') }
      else
        format.html { redirect_to @event }
      end
    end
  end  
  
  def destroy
     @participant = Participant.find(params[:id])
     @participant.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: I18n.t('unjoin_success') }
    end
  end
  
  private
  
  def check_user
   error = false
    @event = Event.find(params[:participant][:event_id])
   if current_user.ratings.where(sport_id: @event.sport_id).exists?
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
   else
     respond_to do |format|
      flash[:error] = I18n.t('need_rating')
      format.html { redirect_to newsport_path(:sport_id => @event.sport_id) }
     end
   end 
  end
 
  
  
  
end