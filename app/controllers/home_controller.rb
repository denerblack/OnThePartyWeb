class HomeController < ApplicationController
  def index
    @banners = Banner.order('created_at DESC').limit(3)

    Event.all.each{|t| t.touch}
    events = Event.close_to(
      current_location[:latitude],
      current_location[:longitude]).limit(6).actives
    @close_events = []
    @other_events = []
    events = Event.ranking(events)

    3.times{ @close_events << events.shift }
    3.times{ @other_events << events.shift }
    @next_events  = Event.close_to_without_order(
      current_location[:latitude],
      current_location[:longitude]).next_events.limit(4)

  end
end
