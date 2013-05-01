class EventPostsController < ApplicationController
 
  def create
    @event_post  = current_user.event_posts.build(params[:event_post])
    @event_post.event_id = params[:event_post][:event_id]
    @event = Event.find(params[:event_post][:event_id])

    respond_to do |format|
      if @event_post.save
        format.html { redirect_to @event }
      else
        format.html { redirect_to @event, alert: I18n.t('post_error') }
      end
    end
  
  end


  
end
