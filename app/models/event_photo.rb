class EventPhoto < ActiveRecord::Base
  belongs_to :event
  belongs_to :user_photo
  attr_accessible :deleted_at, :is_principal, :event, :user_photo

  after_create :increment_counter

  scope :random, order(random)


  def increment_counter
    self.event.photos_count = self.event.photos_count.to_i + 1
    self.event.save
  end
end
