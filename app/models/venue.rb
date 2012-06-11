class Venue < ActiveRecord::Base
  has_and_belongs_to_many :categories
  attr_accessible :address, :contact, :country, :id_foursquare, :latitude, :longitude, :name

end
