class HomeController < ApplicationController
  def index
    @banners = Banner.order('created_at DESC').limit(3)

    Event.all.each{|t| t.update_attribute(:users_count, (1+rand(9999)));t.touch}
    events = Event.close_to(current_location[:latitude],current_location[:longitude],6)
    @close_events = []
    @other_events = []
    
    events.sort! do |a,b|
      comp = (a.users_count <=> b.users_count)
      comp = comp.zero? ? (a.photos_count <=> b.photos_count) : comp
      comp.zero? ? (a.comments_count <=> b.comments_count) : comp
    end
    events.reverse!

    3.times{ @close_events << events.shift }
    3.times{ @other_events << events.shift }

  end
end
