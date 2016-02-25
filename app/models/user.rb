class User < ActiveRecord::Base

  before_save :downcase_email
  validates :username, presence: true, length: {maximum: 50, minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  private

    def downcase_email
      self.email.downcase!
    end

end
