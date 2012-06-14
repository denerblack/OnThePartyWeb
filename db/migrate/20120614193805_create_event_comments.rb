class CreateEventComments < ActiveRecord::Migration
  def change
    create_table :event_comments do |t|
      t.references :event
      t.references :user
      t.text :comment
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :event_comments, :event_id
    add_index :event_comments, :user_id
  end
end
