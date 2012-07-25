class Venue < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :events
  has_many :venue_users
  attr_accessible :address, :contact, :country, :id_foursquare, :latitude, :longitude, :name
  validates :id_foursquare, presence: true, uniqueness: true
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  def self.find_or_create(foursquare_params)
    venue = Venue.where(id_foursquare: foursquare_params[:id_foursquare]).first
    venue = Venue.new(id_foursquare: foursquare_params[:id_foursquare]) unless venue
    venue.attributes = {
      name: foursquare_params[:name],
      latitude: foursquare_params[:latitude],
      longitude: foursquare_params[:longitude],
    }
    venue.save

    category = Category.where(id_foursquare: foursquare_params[:category][:id_foursquare]).first
    category = Category.new(id_foursquare: foursquare_params[:category][:id_foursquare]) unless category
    category.attributes = {
      icon_name: foursquare_params[:category][:icon_name],
      icon_prefix: foursquare_params[:category][:icon_prefix],
      name: foursquare_params[:category][:name],
      plural_name: foursquare_params[:category][:plural_name],
      short_name: foursquare_params[:category][:short_name],
    }

    category.save

    venue.category_ids << category.save unless venue.category_ids.include?(category.id)
    venue.reload
    venue
  end

  def to_api
    result = {
      id_foursquare: self.id_foursquare,
      id: self.id,
      name: self.name,
      latitude: self.latitude,
      longitude: self.longitude,
      categories: [],
      users: []
    }
    result[:categories] = self.categories.collect{|t| t.to_api}
    result[:events] = self.events.actives.collect{|t| t.to_api}
    result[:users] = self.venue_users.actives.collect{|t| t.to_api}
    result
  end


  def self.checkin(user_id,checkin_attributes)
    venue = Venue.find_by_id_foursquare(checkin_attributes[:id_foursquare])
    unless venue
      venue = Venue.new(
        id_foursquare: checkin_attributes[:id_foursquare],
        name: checkin_attributes[:name],
        latitude: checkin_attributes[:latitude],
        longitude: checkin_attributes[:longitude]
      )
      venue.save!
    end

    venue_user = venue.add_user(user_id)

    Event.checkin(user_id,checkin_attributes[:event]) if checkin_attributes[:event]

    venue_user
  end

  def add_user(user_id)
    user = User.find(user_id)

    current_venue_user = self.have_user?(user.id)
    return current_venue_user if current_venue_user
    venue_user = self.venue_users.build(user_id: user.id)
    venue_user if venue_user.save!
  end

  def have_user?(user_id)
    self.venue_users.where(user_id: user_id).where(["created_at >= ?",Time.now - 4.hours]).first
  end
end
