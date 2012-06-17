class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user
  has_many :event_photos
  attr_accessible :deleted_at, :description, :name, :occur_at, :rating, :venue, :user, :users_count, :comments_count, :photos_count

  scope :actives, where("events.updated_at >= ?",Time.now - 4.hours)
  scope :popular, order('events.rating DESC, events.users_count DESC, events.photos_count DESC, events.comments_count DESC')
  scope :with_photos, where("events.photos_count > 0")

  def to_param
    [self.id,self.name.parameterize,'em',self.venue.name.parameterize].join('-')
  end
end
