class JoinTableVenueCategory < ActiveRecord::Migration
  def up
    create_table :venues_categories do |t|
      t.integer :category_id
      t.integer :venue_id
    end
  end

  def down
    drop_table :venues_categories
  end
end
