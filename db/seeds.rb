# encoding: utf-8
require 'csv'
points = CSV.read(File.join(Rails.root, 'db', 'seeds_data', 'points.csv'))

images = []

Dir.entries(File.join(Rails.root, 'db', 'seeds_data','event_photos')).each do |image|
  next if image == '.' || image == '..'
  images << File.join(Rails.root, 'db', 'seeds_data','event_photos', image)
end

Dir.entries(File.join(Rails.root, 'db', 'seeds_data','banners')).each do |image|
  next if image == '.' || image == '..'
  Banner.create(file: File.open(File.join(Rails.root, 'db', 'seeds_data','banners', image)), 
    url: Faker::Internet.domain_name,
    description: Faker::Name.name)
end

1.upto(10) do
  point_user = points[Random.number(points.size)]
  point_venue = points[Random.number(points.size)]
  user = User.create!(:email => Random.email,
    :name => Faker::Name.name,
    :password => 'otp2012',
    :latitude => point_user[0], :longitude => point_user[1]
  )
  venue = Venue.new(:name => Faker::Company.name,
    :latitude => point_venue[0], :longitude => point_venue[1],
    :address => Faker::Address.street_address(true)
  )
  venue.save(validate: false)
end


1.upto(30) do
  user = User.order("rand()").first
  event = Event.new(:name => Faker::Company.name,
    :description => Faker::Lorem.paragraphs(4),
    :occur_at => Random.date    
  )
  event.venue = Venue.order("rand()").first
  event.user = user
  event.users_count = Random.number(99)
  event.rating = Random.number(6)
  event.comments_count = Random.number(99)
  event.save!

  1.upto(Random.number(images.size)) do
    UserPhoto.create_with_event(File.open(images[Random.number(images.size)]), user, event)
  end


  # sleep(1)
end
