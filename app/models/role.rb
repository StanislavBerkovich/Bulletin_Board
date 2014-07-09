class Role < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 1}, uniqueness: true
  has_many :users

  def self.admin_role
    Role.find_by(name: 'admin')
  end

  def self.user_role
    Role.find_by(name: 'user')
  end

  def Role.get_avalible
    Role.pluck(:name)
  end

  def to_s
    name
  end

end
