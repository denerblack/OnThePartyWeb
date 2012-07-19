require 'spec_helper'

describe Api::EventsController do
  it "get none event" do
    get :index, format: :json
    JSON.parse(response.body).should have(:no).element
  end
  
  it "get 2 global events" do
    event = FactoryGirl.create(:event)
    FactoryGirl.create(:event)
    get :index, format: :json
    res = JSON.parse(response.body)
    res.should have(2).elements
    res.first.should eql(event.to_api)
  end
  
  it "get 2 venue events in 3" do
    venue = FactoryGirl.create(:venue)
    events = []
    events << FactoryGirl.create(:event, venue_id: venue.id)
    events << FactoryGirl.create(:event, venue_id: venue.id)
    FactoryGirl.create(:event)
    
    get :index, {venue_id: venue.id}, format: :json
    # res = JSON.parse(response.body)
    # puts res.inspect
    # res.should have(2).elements
    # res.first.should eql(events.first.to_api)
  end
end