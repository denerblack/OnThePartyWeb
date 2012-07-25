class Banner < ActiveRecord::Base
  attr_accessible :description, :file, :url

  has_attached_file :file, :styles => { 
    :normal => "866x420", 
    :thumb => "75x75#"
  },
  :default_style => :normal
end
