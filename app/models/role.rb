class Role < ActiveRecord::Base
  has_many :users

  def self.guest_role
    Role.find(3)
  end

  def self.admin_role
    Role.find(1)
  end

  def self.user_role
    Role.find(2)
  end

  def Role.get_avalible
    Role.pluck(:name)
  end

  def to_s
    name
  end

end
