class Type < ActiveRecord::Base
  validates :name, presence: true
  has_many :adverts

  def to_s
    self.name
  end
end
