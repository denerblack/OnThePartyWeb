class Event < ActiveRecord::Base
  default_scope where("deleted_at IS NULL")
  belongs_to :venue
  belongs_to :user
  has_many :event_photos
  has_many :event_users
  has_many :event_comments
  delegate :latitude, :longitude, :address, to: :venue

  attr_accessor :first_photo
  attr_accessible :deleted_at, :description, :name, :occur_at, 
  :latitude, :longitude, :address, :first_photo, :venue_id

  scope :next_events, where("events.occur_at >= ?",Time.now - 30.minutes).order('occur_at')
  scope :actives, where("events.updated_at >= ? AND events.occur_at <= ? ",Time.now - 4.hours,Time.now)
  scope :popular, order('events.users_count DESC, events.photos_count DESC, events.comments_count DESC')
  scope :with_photos, where("events.photos_count > 0")

  validates_presence_of :name, :occur_at, :description
  validates_presence_of :user_id, on: :update


  def self.close_to_without_order(latitude,longitude)
    Event.select("events.*, ( 3959 * ACOS( COS( RADIANS( #{latitude} ) ) * COS( RADIANS( latitude ) ) * COS( RADIANS( longitude ) - RADIANS( #{longitude} ) ) + SIN( RADIANS( #{latitude} ) ) * SIN( RADIANS( latitude ) ) ) ) AS distance").
    joins(:venue).
    with_photos
  end

  def self.close_to(latitude,longitude)
    self.close_to_without_order(latitude,longitude).order('distance')
  end

  def self.ranking(events)
    events = events.sort do |a,b|
      comp = (a.users_count <=> b.users_count)
      comp = comp.zero? ? (a.photos_count <=> b.photos_count) : comp
      comp.zero? ? (a.comments_count <=> b.comments_count) : comp
    end
    events = events.reverse
    events
  end

  def to_api
    result = {
      name: self.name,
      description: self.description,
      occur_at: self.occur_at,
      rating: self.rating,
      users_count: self.users_count,
      photos_count: self.photos_count,
      comments_count: self.comments_count,
      user: self.user.to_api,
      photos: [],
      users: [],
      comments: [],
    }
    
    
    
    result[:photos] = self.event_photos.limit(5).collect{|t| t.to_api} unless self.event_photos.blank?
    result[:users] = self.event_users.limit(5).collect{|t| t.to_api} unless self.event_users.blank?
    result[:comments] = self.event_comments.limit(5).collect{|t| t.to_api} unless self.event_comments.blank?
    
  end

  def self.find_actives_by_venue_id(venue_id)
     Event.actives.where(venue_id: venue_id)
  end

  def to_param
    [self.id,self.name.parameterize,'em',self.venue.name.parameterize].join('-')
  end

  def self.checkin(user_id,checkin_attributes)
    event = checkin_attributes[:id] ? Event.find(checkin_attributes[:id]) : nil
    unless event
      event = Event.new(
        name: checkin_attributes[:name],
        venue_id: checkin_attributes[:venue_id],
        user_id: user_id,
        occur_at: Time.now
      )
      event.save!
    end

    event.add_user(user_id)
   end

   def add_user(user_id)
    user = User.find(user_id)

    current_event_user = self.have_user?(user.id)
    return current_event_user if current_event_user
    event_user = self.event_users.build(user_id: user.id)
    event_user if event_user.save!
  end

  def have_user?(user_id)
    self.event_users.where(user_id: user_id).where(["created_at >= ?",Time.now - 4.hours]).first
  end
end
