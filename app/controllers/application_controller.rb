class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :user_location

  def user_location
    if current_user.nil?
      {:latitude => request.location.latitude, :longitude => request.location.longitude}
    else
      {:latitude => current_user['latitude'], :longitude => current_user['longitude']}
    end
  end

  def current_user
    session[:current_user]
  end
end
