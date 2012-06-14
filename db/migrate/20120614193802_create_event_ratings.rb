class CreateEventRatings < ActiveRecord::Migration
  def change
    create_table :event_ratings do |t|
      t.references :event
      t.references :user
      t.integer :rating
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :event_ratings, :event_id
    add_index :event_ratings, :user_id
  end
end
