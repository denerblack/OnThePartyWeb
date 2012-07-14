class Api::EventsController < ApplicationController 
  def create_event
    event = Event.create(:venue_id => params[:venue_id].to_i,:user_id => params[:user_id].to_i, :name => params[:name], :description => params[:description])
    respond_to do |format|
      format.json {render :json => event} 
   end
  end

  def find_by_venue_and_time
    event = Event.find_by_venue_and_time(params[:venue_id],params[:time].to_time)
    respond_to do |format|
      format.json {render :json => event} 
    end
  end
end
