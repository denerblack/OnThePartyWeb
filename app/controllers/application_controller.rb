class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_location

  def current_location
    session[:current_location] ||= {:latitude => request.location.latitude, :longitude => request.location.longitude}
    session[:current_location]
  end
end