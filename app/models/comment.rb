class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :parent, polymorphic: true

  has_many :tempsetters, as: :post,
           class_name: "Temperature",
           dependent: :destroy

  has_many :subcomments, as: :parent,
                         class_name: "Comment",
                         dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :active, inclusion: { in: [true, false] }
  validates :content, presence: true
  validates :user_id, presence: true
  validates :parent_id, presence: true
  validates :parent_type, presence: true
  validates_associated :user, :parent

  def to_json
    self.as_json
  end

end
