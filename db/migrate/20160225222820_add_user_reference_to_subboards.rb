class AddUserReferenceToSubboards < ActiveRecord::Migration
  def change
    add_reference :subboards, :owner, index: true, foreign_key: true
  end
end
