class Api::EventsController < ApplicationController

  def create
    event = Event.crate(:venue_id => params[:venue_id],:user_id => params[:user_id], :name => params[:name], :description => params[:description])
   
  respond_to do |format|
    format.json {render :json => event} 
  end

  end

end
