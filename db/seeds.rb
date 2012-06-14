# encoding: utf-8
require 'csv'
points = CSV.read(File.join(Rails.root, 'db', 'seeds_data', 'points.csv'))
suckr = ImageSuckr::GoogleSuckr.new

images = []
1.upto(12) do
  begin
    search = "night party club at #{Faker::Address.country}"
    puts 'procurando por'
    puts search
    images << suckr.get_image_file({"q" => search})
  end
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
    :occur_at => Random.date
  )

  user_photo = user.user_photos.build(:file => images[Random.number(images.size)])
  user_photo.save!

  # sleep(1)
end