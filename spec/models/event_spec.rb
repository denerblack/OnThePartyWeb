require 'spec_helper'

describe Event do
  it 'should raise in add user with fake id' do
    event = FactoryGirl.create(:event)
    lambda{event.add_user(nil)}.should raise_error
    lambda{event.add_user(-1)}.should raise_error
  end

  it 'should add user in event' do
    user  = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event)
    event.add_user(user.id).should be_true
    event.event_users.should have(1).element
  end

  it 'should add user in event two times in 4 hours and have only 1 register' do
    user  = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event)
    event.add_user(user.id)
    event.add_user(user.id)
    event.event_users.should have(1).element
  end

  it 'should raise checkin without event' do
    lambda { Event.checkin(nil,nil) }.should raise_error
    lambda { Event.checkin(nil,{}) }.should raise_error
    lambda { Event.checkin(-1,{}) }.should raise_error
    lambda { Event.checkin(-1,{id: nil}) }.should raise_error
    lambda { Event.checkin(-1,{id: 1}) }.should raise_error

    lambda {
      user  = FactoryGirl.create(:user)
      Event.checkin(user.id,{id: -1})
    }.should raise_error

  end

  
  
  it 'should do check-in and create event' do
    user  = FactoryGirl.create(:user)
    venue = FactoryGirl.create(:venue)
    event = FactoryGirl.build(:event, venue_id: venue.id)
    event_user = Event.checkin(user.id,{
      name: event.name,
      venue_id: event.venue_id
    })
    event_user.should be_true
    event_user.user_id.should eql(user.id)
  end

  it 'should do check-in' do
    user  = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event)
    event_user = Event.checkin(user.id,{id: event.id})
    event_user.should be_true
    event_user.user_id.should eql(user.id)
  end
end