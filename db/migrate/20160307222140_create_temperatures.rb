class CreateTemperatures < ActiveRecord::Migration
  def change
    create_table :temperatures do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
