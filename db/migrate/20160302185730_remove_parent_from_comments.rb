class RemoveParentFromComments < ActiveRecord::Migration
  def change
    remove_reference :comments, :parent, index: true, foreign_key: true
    add_reference :comments, :parent, polymorphic: true, index: true
  end
end
