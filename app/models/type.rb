class Type < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: {minimum: 1}
  has_many :adverts, dependent: :destroy

  def to_s
    self.name
  end
end
