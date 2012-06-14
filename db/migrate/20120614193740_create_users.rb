class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :facebook
      t.string :twitter
      t.float :latitude
      t.float :longitude
      t.string :address
      t.boolean :promoter
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
