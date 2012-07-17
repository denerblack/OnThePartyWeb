require 'spec_helper'

describe Venue do
  it 'should raise in add user with fake id' do
    venue = FactoryGirl.create(:venue)
    lambda{venue.add_user(nil)}.should raise_error
    lambda{venue.add_user(1)}.should raise_error
  end

  it 'should add user in venue' do
    user  = FactoryGirl.create(:user)
    venue = FactoryGirl.create(:venue)
    venue.add_user(user.id).should be_true
    venue.venue_users.should have(1).element
  end

  it 'should add user in venue two times in 4 hours and have only 1 register' do
    user  = FactoryGirl.create(:user)
    venue = FactoryGirl.create(:venue)
    venue.add_user(user.id)
    venue.add_user(user.id)
    venue.venue_users.should have(1).element
  end

  it 'should raise checkin without venue' do
    lambda { Venue.checkin(nil,nil) }.should raise_error
    lambda { Venue.checkin(nil,{}) }.should raise_error
    lambda { Venue.checkin(1,{}) }.should raise_error
    lambda { Venue.checkin(1,{id_foursquare: nil}) }.should raise_error
    lambda { Venue.checkin(1,{id_foursquare: 1}) }.should raise_error

    lambda {
      user  = FactoryGirl.create(:user)
      Venue.checkin(user.id,{id_foursquare: 1})
    }.should raise_error

  end

  
  
  it 'should do check-in and create venue' do
    user  = FactoryGirl.create(:user)
    venue = FactoryGirl.build(:venue)
    venue_user = Venue.checkin(user.id,{
      id_foursquare: venue.id_foursquare,
      name: venue.name,
      latitude: venue.latitude,
      longitude: venue.longitude
    })
    venue_user.should be_true
    venue_user.user_id.should eql(user.id)
  end

  it 'should do check-in without event' do
    user  = FactoryGirl.create(:user)
    venue = FactoryGirl.create(:venue)
    venue_user = Venue.checkin(user.id,{id_foursquare: venue.id_foursquare})
    venue_user.should be_true
    venue_user.user_id.should eql(user.id)
  end

  it 'should do check-in with existing event' do
    user  = FactoryGirl.create(:user)
    venue = FactoryGirl.create(:venue)
    event = FactoryGirl.create(:event, user_id: user.id, venue_id: venue.id)

    venue_user = Venue.checkin(user.id,{id_foursquare: venue.id_foursquare, event: {id: event.id}})
    venue_user.should be_true
    venue_user.user_id.should eql(user.id)
  end
end