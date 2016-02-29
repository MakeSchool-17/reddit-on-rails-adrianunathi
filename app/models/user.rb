class User < ActiveRecord::Base
  before_save :downcase_email!

  has_many :subboards, dependent: :destroy
  has_many :moderating, foreign_key: "user_id",
                        class_name: "Moderator",
                        dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :username, presence: true,
                       length: { maximum: 50, minimum: 5 },
                       uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  private

    def downcase_email!
      self.email.downcase!
    end

end
