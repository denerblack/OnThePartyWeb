class Api::VenuesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:find_or_create]


  def find_or_create
    venue = Venue.find_or_create(params[:foursquare_params])

    
    respond_to do |format|
      format.json { render :json => venue.to_api}
    end
    
  end
end
