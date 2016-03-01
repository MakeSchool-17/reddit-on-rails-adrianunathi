class AddTemperatureToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :temperature, :integer
  end
end
