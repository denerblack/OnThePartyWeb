class UserPhoto < ActiveRecord::Base
  belongs_to :user
  attr_accessible :deleted_at, :description, :file, :user

  has_attached_file :file, :styles => { 
    :medium => "260x292#", 
    :list => "260x171#", 
    :thumb => "75x75#",
    :big => "860x455#"
  }, default_style: :thumb

  def self.create_with_event(file_path, user, event)
    # EventPhoto.transaction do 
      user_photo = UserPhoto.create(:file => file_path, :user => user)
      event_photo = EventPhoto.create(:user_photo => user_photo, :event => event)
      user_photo
  #   end
  # rescue
  #   false
  end
end
