class Api::EventsController < ApplicationController 
  def create_event
    event = Event.create(:venue_id => params[:venue_id].to_i,:user_id => params[:user_id].to_i, :name => params[:name], :description => params[:description])
    respond_to do |format|
      format.json {render :json => event} 
   end
  end

  def find_actives_by_venue_id
    events = Event.find_actives_by_venue_id(params[:venue_id])
    respond_to do |format|
      #format.json {render :json => event} 
      format.json { render json: events.collect{|t| t.to_api} }
    end
  end
  
  def index
    events = []
    
    unless params[:venue_id]
      events = Event.actives
    else
      events = Event.where(venue_id: params[:venue_id]).actives
    end

    # puts events.collect{|t| t.to_api}.inspect
    
    respond_to do |format|
      format.json { render json: events.collect{|t| t.to_api} }
    end
  end
  
  def close_to
    events = Event.close_to(params[:latitude],params[:longitude])
    respond_to do |format|
      format.json { render json: events.collect{|t| t.to_api}}
    end
  end


end
