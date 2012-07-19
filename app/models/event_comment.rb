class EventComment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :comment, :deleted_at
  
  def to_api
    {
      id: self.id,
      comment: self.comment,
      created_at: self.created_at.to_s(:db),
      user: self.user.to_api
    }
  end
end
