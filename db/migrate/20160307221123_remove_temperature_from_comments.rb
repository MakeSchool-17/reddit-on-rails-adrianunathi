class RemoveTemperatureFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :temperature, :integer
  end
end
