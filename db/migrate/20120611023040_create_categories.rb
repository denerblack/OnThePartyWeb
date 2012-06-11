class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :id_foursquare
      t.string :name
      t.string :plural_name
      t.string :short_name
      t.string :icon_prefix
      t.string :icon_name

      t.timestamps
    end
  end
end
