class User < ActiveRecord::Base
  default_scope -> { order('surname DESC') }
  scope :admins, -> { where role_id: Role.admin_role.id }
  scope :users, -> { where role_id: Role.user_role.id }

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
