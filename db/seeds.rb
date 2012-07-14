# encoding: utf-8
require 'csv'
points = CSV.read(File.join(Rails.root, 'db', 'seeds_data', 'points.csv'))

images = []

Dir.entries(File.join(Rails.root, 'db', 'seeds_data','event_photos')).each do |image|
  next if image == '.' || image == '..'
  images << File.join(Rails.root, 'db', 'seeds_data','event_photos', image)
end

1.upto(10) do
  point_user = points[Random.number(points.size)]
  point_venue = points[Random.number(points.size)]
  user = User.create!(:email => Random.email,
    :name => Faker::Name.name,
    :password => 'otp2012',
    :latitude => point_user[0], :longitude => point_user[1]
  )
  venue = Venue.create!(:name => Faker::Company.name,
    :latitude => point_venue[0], :longitude => point_venue[1],
    :address => Faker::Address.street_address(true)
  )
end


1.upto(30) do
  user = User.order("rand()").first
  event = Event.create!(:venue => Venue.order("rand()").first,
    :user => user,
    :name => Faker::Company.name,
    :description => Faker::Lorem.paragraphs(4),
    :occur_at => Random.date,
    :users_count => Random.number(99),
    :rating => Random.number(6),
    :comments_count => Random.number(99)
  )

  1.upto(Random.number(images.size)) do
    UserPhoto.create_with_event(File.open(images[Random.number(images.size)]), user, event)
  end


  # sleep(1)
end
