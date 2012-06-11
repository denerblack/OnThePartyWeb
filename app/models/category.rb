class Category < ActiveRecord::Base
  has_and_belongs_to_many :venues
  attr_accessible :icon_name, :icon_prefix, :id_foursquare, :name, :plural_name, :short_name
end
