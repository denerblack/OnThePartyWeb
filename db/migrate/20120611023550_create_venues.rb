class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :id_foursquare
      t.string :name
      t.string :contact
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :country

      t.timestamps
    end
  end
end
