class Post < ActiveRecord::Base
  after_initialize :init

  belongs_to :user
  belongs_to :subboard

  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :subboard_id, presence: true
  validates_associated :user
  validates_associated :subboard

  validates_format_of :link, with: URI::regexp(%w(http https)),
                             if: lambda { |post| post.link.present? }

  validates :temperature, presence: true,
                          numericality: { only_integer: true }

  validate :link_xor_content

  def init
    self.temperature ||= 0
  end

  private

    def link_xor_content
      unless link.nil? ^ content.nil?
        errors.add(:base, "Must have link or content, but not both")
      end
    end

end
