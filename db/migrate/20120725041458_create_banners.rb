class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.has_attached_file :file
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
