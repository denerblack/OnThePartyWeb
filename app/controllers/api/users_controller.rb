class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:find_or_create] 
  
  def find_or_create
    user = User.find_or_create(params[:user])

    respond_to do |format|
      format.json { render :json => user.to_json}
    end
    
  end

end
