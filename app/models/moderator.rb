class Moderator < ActiveRecord::Base

  belongs_to :user
  belongs_to :subboard

  validates_associated :user
  validates_associated :subboard

end
