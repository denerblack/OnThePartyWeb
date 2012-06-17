class AddTotalFields < ActiveRecord::Migration
  def up
    change_column :events, :rating, :float
    add_column :events, :users_count, :integer
    add_column :events, :photos_count, :integer
    add_column :events, :comments_count, :integer
  end

  def down
    remove_column :events, :comments_count
    remove_column :events, :photos_count
    remove_column :events, :users_count
    change_column :events, :rating, :integer
  end
end
