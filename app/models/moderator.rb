class Moderator < ActiveRecord::Base

  belongs_to :user
  belongs_to :subboard

  validates :user_id, presence: true
  validates :subboard_id, presence: true

  validates_associated :user
  validates_associated :subboard

end
