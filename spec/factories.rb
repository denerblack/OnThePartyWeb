# encoding: utf-8
FactoryGirl.define do

  factory :user do
    name "usuario"
    sequence(:email) {|n| "usuario-#{n}@ontheparty.com.br"}
  end

  factory :venue do
    sequence(:id_foursquare) {|n| "fs-#{n}"}
    sequence(:name) {|n| "Local #{n}"}
    latitude '43'
    longitude '-70'
  end

  factory :event do
    association :venue
    association :user
    sequence(:name) {|n| "Evento #{n}"}
    occur_at { Time.now }
  end
end