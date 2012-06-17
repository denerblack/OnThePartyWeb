module HomeHelper
  def events_for_location(limit = nil)
    events = Event.popular.with_photos
    events = events.limit(limit) if limit
    events
  end
end
