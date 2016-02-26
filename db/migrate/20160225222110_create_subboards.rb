class CreateSubboards < ActiveRecord::Migration
  def change
    create_table :subboards do |t|
      t.string :name
      t.boolean :private
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :subboards, [:user_id, :created_at]
  end
end
