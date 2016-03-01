class AddTemperatureToComments < ActiveRecord::Migration
  def change
    add_column :comments, :temperature, :integer
  end
end
