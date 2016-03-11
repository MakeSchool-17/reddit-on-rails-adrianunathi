class Subscription < ActiveRecord::Base

  belongs_to :user
  belongs_to :subboard

  validates :user_id, presence: true
  validates :subboard_id, presence: true

  validates_uniqueness_of :user_id, :scope => :subboard_id

  validates_associated :user
  validates_associated :subboard

  def to_json
    { username: self.user.username, name: self.subboard.name }
  end

end
