class Api::EventsController < ApplicationController 
  def create_event
    event = Event.create(:venue_id => params[:venue_id].to_i,:user_id => params[:user_id].to_i, :name => params[:name], :description => params[:description])
    respond_to do |format|
      format.json {render :json => event} 
   end
  end

end
