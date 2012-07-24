class Event < ActiveRecord::Base
  default_scope where("deleted_at IS NULL")
  belongs_to :venue
  belongs_to :user
  has_many :event_photos
  has_many :event_users
  has_many :event_comments
  attr_accessible :deleted_at, :description, :name, :occur_at, 
  :rating, :venue, :venue_id, :user, :user_id, :users_count, :comments_count, :photos_count

  scope :actives, where("events.updated_at >= ?",Time.now - 4.hours)
  scope :popular, order('events.rating DESC, events.users_count DESC, events.photos_count DESC, events.comments_count DESC')
  scope :with_photos, where("events.photos_count > 0")

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
     Event.where(["venue_id = ? and events.update_at >= ?", venue_id,Time.now - 4.hours])
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
