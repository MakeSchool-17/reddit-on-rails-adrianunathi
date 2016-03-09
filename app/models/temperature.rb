class Temperature < ActiveRecord::Base

  belongs_to :user
  belongs_to :post, polymorphic: true

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :post_type, presence: true
  validates :temptype, presence: true

  validates_associated :user
  validates_associated :post

end
