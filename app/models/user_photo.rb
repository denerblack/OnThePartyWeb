class UserPhoto < ActiveRecord::Base
  belongs_to :user
  attr_accessible :deleted_at, :description, :file

  has_attached_file :file, :styles => { 
    :medium => "260x292#", 
    :thumb => "75x75#"
  }
end
