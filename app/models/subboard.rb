class Subboard < ActiveRecord::Base
  before_create :lowercase_name

  belongs_to :owner
  
  validates :name, presence: true,
                   length: { minimum: 3, maximum: 30 },
                   exclusion: { in: %w(\s) },
                   uniqueness: true
  validates :private, inclusion: { in: [true, false] }
  validates :owner, presence: true
  validates_associated :owner

  private

    def lowercase_name
      self.name.lowercase!
    end

end
