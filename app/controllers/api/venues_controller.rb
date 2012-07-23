class Api::VenuesController < ApplicationController
  def find_or_create
    venue = Venue.find_or_create(params[:venue])

    
    respond_to do |format|
      format.json { render :json => venue.to_api}
    end
    
  end
end
