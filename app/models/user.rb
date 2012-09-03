class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :address, :deleted_at, :facebook, :latitude, :longitude, :name, :promoter, :twitter
  has_many :user_photos

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
