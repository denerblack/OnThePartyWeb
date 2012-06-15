class EventPhoto < ActiveRecord::Base
  belongs_to :event
  belongs_to :user_photo
  attr_accessible :deleted_at, :is_principal
end
