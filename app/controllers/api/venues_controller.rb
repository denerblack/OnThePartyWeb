class Api::VenuesController < ApplicationController
  def find_or_create
    venue = Venue.find_by_id_foursquare(params[:id_foursquare])
    category = Category.find_by_id_foursquare(params[:id_foursquare])
    if !venue
      venue = Venue.create(:id_foursquare => params[:id_foursquare], :name => params[:name], :contact => params[:contact], :address => params[:address], :latitude => params[:latitude].to_f, :longitude => params[:longitude], :country => params[:country]) 
    end
    respond_to do |format|
      format.json { render :json => venue}
    end
    
  end
end
