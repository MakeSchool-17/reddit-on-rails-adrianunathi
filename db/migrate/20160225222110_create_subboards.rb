class CreateSubboards < ActiveRecord::Migration
  def change
    create_table :subboards do |t|
      t.string :name
      t.boolean :private

      t.timestamps null: false
    end
  end
end
