class Comment < ActiveRecord::Base
  after_initialize :init

  belongs_to :user
  belongs_to :parent, polymorphic: true

  has_many :subcomments, as: :parent,
                         class_name: "Comment",
                         dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true
  validates :user_id, presence: true
  validates :parent_id, presence: true
  validates :parent_type, presence: true
  validates_associated :user, :parent

  validates :temperature, presence: true,
                          numericality: { only_integer: true }

  def init
    self.temperature ||= 0
  end

end
