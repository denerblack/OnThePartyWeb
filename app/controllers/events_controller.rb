class EventsController < ApplicationController
  def live_data
    event = Event.find(params[:id])
    render :nothing => true if event.nil?
    render :json => {:photos_count => event.photos_count, :users_count => event.users_count, :comments_count => event.comments_count, :rating => event.rating}
  end
end
