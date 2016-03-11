class AddActiveToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :active, :boolean, :null => true, :default => true
  end
end
