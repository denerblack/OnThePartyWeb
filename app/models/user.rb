class User < ActiveRecord::Base
  has_many :user_photos
  attr_accessible :address, :deleted_at, :email, :facebook, :latitude, :longitude, :name, :password, :promoter, :twitter

  # geocoded_by :full_street_address
  # after_validation :geocode 
  def to_api
    {
      id: self.id,
      name: self.name
    }
  end

  def self.find_or_create(user_params)
    user = User.where(facebook: user_params[:facebook]).first
    user = User.create(facebook: user_params[:facebook], name: user_params[:name]) unless user
  end

end
