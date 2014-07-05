class Ability
  include CanCan::Ability

  def initialize(user)


    def initialize(user)
      user ||= User.new # guest user

      if user.is? Role.admin_role
        can :destroy, Advert
        can [:edit, :create], User
        can [:create], Type
        can [:destroy], Type do |t|
          t.adverts.empty?
        end
        cannot [:edit, :create], Advert
      elsif user.is Role.user_role
        can :read, :all
        can :create, Advert
        can [:update, :destroy], Advert do |advert|
          advert.try(:user) == user
        end
        can :update, User do |u|
          u == user
        end
      elsif
        can :read, Advert do |advert|
          advert.try(:state) == :new
        end
      end
    end
  end
end