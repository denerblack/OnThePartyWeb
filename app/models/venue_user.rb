class VenueUser < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user
  attr_accessible :user_id
  validates :user_id, presence: true
end
