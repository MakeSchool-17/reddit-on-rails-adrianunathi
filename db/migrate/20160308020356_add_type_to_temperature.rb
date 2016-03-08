class AddTypeToTemperature < ActiveRecord::Migration
  def change
    add_column :temperatures, :temptype, :string
  end
end
