class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :surname, presence: true

  has_many :adverts, dependent: :destroy
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def is? request_role
    self.role.to_s == request_role.to_s
  end

end
