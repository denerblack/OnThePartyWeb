class CreateVenueUsers < ActiveRecord::Migration
  def change
    create_table :venue_users do |t|
      t.references :venue
      t.references :user

      t.timestamps
    end
    add_index :venue_users, :venue_id
    add_index :venue_users, :user_id
  end
end
