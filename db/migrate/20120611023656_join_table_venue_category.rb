class JoinTableVenueCategory < ActiveRecord::Migration
  def up
    create_table :categories_venues do |t|
      t.integer :category_id
      t.integer :venue_id
    end
  end

  def down
    drop_table :categories_venues
  end
end
