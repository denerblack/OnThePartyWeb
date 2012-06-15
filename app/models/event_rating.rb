class EventRating < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :deleted_at, :rating
end
