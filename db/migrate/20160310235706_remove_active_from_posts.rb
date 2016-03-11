class RemoveActiveFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :active, :boolean
  end
end
