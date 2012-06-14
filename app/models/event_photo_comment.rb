class EventPhotoComment < ActiveRecord::Base
  belongs_to :event_photo
  belongs_to :user
  attr_accessible :comment, :deleted_at
end
