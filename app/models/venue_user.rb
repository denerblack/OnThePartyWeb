class VenueUser < ActiveRecord::Base
  scope :actives, where("venue_users.updated_at >= ?",Time.now - 4.hours)
  belongs_to :venue
  belongs_to :user
  attr_accessible :user_id
  validates :user_id, presence: true

  def to_api
    self.user.to_api
  end
end
