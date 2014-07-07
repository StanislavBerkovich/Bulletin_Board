class Type < ActiveRecord::Base
  validates :name, presence: true
  has_many :adverts, dependent: :destroy



  def to_s
    self.name
  end
end
