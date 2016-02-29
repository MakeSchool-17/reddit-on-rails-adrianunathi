class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :post
  belongs_to :parent

  validates :content, presence: true
  validates :user_id, presence: true
  # validates :post_id, presence: true
  validates_associated :user, :parent

end
