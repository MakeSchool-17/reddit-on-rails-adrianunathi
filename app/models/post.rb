class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :subboard

  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates_associated :user
  validates :subboard_id, presence: true
  validates_associated :subboard

  validates_format_of :link, :with => URI::regexp(%w(http https)),
                             :if => lambda { |object| object.link.present? }

  validate :link_xor_content

  private

    def link_xor_content
      unless link.nil? ^ content.nil?
        errors.add(:base, "Must have link or content, but not both")
      end
    end

end
