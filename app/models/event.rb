class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user
  attr_accessible :deleted_at, :description, :name, :occur_at, :rating, :venue, :user
end
