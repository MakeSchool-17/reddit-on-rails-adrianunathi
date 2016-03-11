class AddActiveToComments < ActiveRecord::Migration
  def change
    add_column :comments, :active, :boolean, :null => true, :default => true
  end
end
