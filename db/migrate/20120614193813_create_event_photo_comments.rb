class CreateEventPhotoComments < ActiveRecord::Migration
  def change
    create_table :event_photo_comments do |t|
      t.references :event_photo
      t.references :user
      t.text :comment
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :event_photo_comments, :event_photo_id
    add_index :event_photo_comments, :user_id
  end
end
