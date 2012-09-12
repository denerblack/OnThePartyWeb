class EventUser < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :user_id
  validates :user_id, presence: true

  after_create :increment_counter

  def increment_counter
    self.event.users_count = self.event.users_count.to_i + 1
    self.event.save
  end
end
