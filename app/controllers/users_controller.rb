class UsersController < ApplicationController
  def random_login
    session[:current_user] = User.order('rand()').first.attributes
    session[:current_location] = {:latitude => current_user['latitude'], :longitude => current_user['longitude']}
    redirect_to root_path
  end
end
