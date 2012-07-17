class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user
  has_many :event_photos
  has_many :event_users
  attr_accessible :deletedd_at, :description, :name, :occur_at, :rating, :venue, :venue_id, :user, :user_id, :users_count, :comments_count, :photos_count

  scope :actives, where("events.updated_at >= ?",Time.now - 4.hours)
  scope :popular, order('events.rating DESC, events.users_count DESC, events.photos_count DESC, events.comments_count DESC')
  scope :with_photos, where("events.photos_count > 0")

  class << self
    def find_by_venue_and(venue_id,time)
      Event.where(["venue_id = ? and ? between occur_an and deleted_at", venue_id,time]).first
    end
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
