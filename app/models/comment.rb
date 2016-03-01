class Comment < ActiveRecord::Base
  after_initialize :init

  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: "Comment"

  has_many :subcomments, foreign_key: "parent_id",
                         class_name: "Comment",
                         dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates_associated :user, :post, :parent

  validates :temperature, presence: true,
                          numericality: { only_integer: true }

  def init
    self.temperature ||= 0
  end

end
