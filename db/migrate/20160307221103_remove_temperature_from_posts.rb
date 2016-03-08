class RemoveTemperatureFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :temperature, :integer
  end
end
