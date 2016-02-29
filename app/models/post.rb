class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :subboard

  #has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates_associated :user
  validates :subboard_id, presence: true
  validates_associated :subboard

  # validate :check_if_url_valid

  validate :link_xor_content

  private

    def link_xor_content
      unless link.nil? ^ content.nil?
        errors.add(:base, "Must have link or content, but not both")
      end
    end
end
