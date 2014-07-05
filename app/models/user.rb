class User < ActiveRecord::Base
  has_many :adverts
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def is? request_role
    self.role.to_s == request_role.to_s
  end

  def role= role
    role.users << self
  end

end
