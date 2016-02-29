class Subboard < ActiveRecord::Base
  before_save :downcase_name!,
              :remove_spaces_for_name!

  belongs_to :user
  has_many :moderators, dependent: :destroy
  has_many :posts, foreign_key: "subboard_id",
           class_name: "Post",
           dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true,
                   length: { minimum: 3, maximum: 30 },
                   uniqueness: { case_sensitive: false }
  validates :private, inclusion: { in: [true, false] }
  validates :user_id, presence: true
  validates_associated :user

  private

    def downcase_name!
      self.name.downcase!
    end

    def remove_spaces_for_name!
      self.name.delete!(' ')
    end

end
