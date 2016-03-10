class Subboard < ActiveRecord::Base

  before_validation :downcase_name!,
                    :remove_spaces_for_name!,
                    unless: lambda { |s| !s.name }

  belongs_to :user
  has_many :moderators, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :subscribers, foreign_key: "subboard_id",
           class_name: "Subscription",
           dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true,
                   length: { minimum: 3, maximum: 30 },
                   uniqueness: { case_sensitive: false },
                   format: { with: /^[A-Za-z0-9.&]*\z/,
                             multiline: true }
  validates :private, inclusion: { in: [true, false] }
  validates :user_id, presence: true
  validates_associated :user

  def to_json
    { :id => self.id, :name => self.name, :private => self.private, :owner_username => self.user.username }
  end

  private

    def downcase_name!
      self.name.downcase!
    end

    def remove_spaces_for_name!
      self.name.delete!(' ')
    end

end
