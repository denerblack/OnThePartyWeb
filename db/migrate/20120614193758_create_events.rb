class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :venue
      t.references :user
      t.string :name
      t.text :description
      t.datetime :occur_at
      t.integer :rating
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :events, :venue_id
    add_index :events, :user_id
  end
end
