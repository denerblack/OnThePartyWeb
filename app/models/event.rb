class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user
  attr_accessible :deleted_at, :description, :name, :occur_at, :rating, :venue, :user

  scope :actives, where("events.updated_at >= ?",Time.now - 4.hours)
  scope :popular, order('rating DESC, users_count DESC, photos_count DESC, comments_count DESC')
end
