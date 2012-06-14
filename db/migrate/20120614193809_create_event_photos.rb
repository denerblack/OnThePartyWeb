class CreateEventPhotos < ActiveRecord::Migration
  def change
    create_table :event_photos do |t|
      t.references :event
      t.references :user_photo
      t.boolean :is_principal
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :event_photos, :event_id
    add_index :event_photos, :user_photo_id
  end
end
