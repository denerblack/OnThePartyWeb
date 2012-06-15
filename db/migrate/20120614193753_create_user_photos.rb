class CreateUserPhotos < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.references :user
      t.has_attached_file :file
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :user_photos, :user_id
  end
end
