class UsersController < ApplicationController
  def random_login
    session[:current_user] = User.order('rand()').first.attributes
    redirect_to root_path
  end
end
