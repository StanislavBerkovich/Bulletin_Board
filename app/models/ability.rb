class Ability
  include CanCan::Ability

  def initialize(user)


    def initialize(user)
      user ||= User.new

      if user.is? Role.admin_role
        can :read, :all
        can [:approve, :reject], Advert do |advert|
          advert.try(:state_is?, :new)
        end
        can :destroy, Advert do |advert|
          advert.try(:state_is?, :published)
        end
        can [:assign_roles, :edit, :create, :destroy], User
        can :create, Type
        can :destroy, Type do |t|
          t.adverts.empty?
        end
        cannot [:edit, :create], Advert
      elsif user.is? Role.user_role
        can :read, :all
        can :create, Advert
        can :update, Advert do |advert|
          [:draft, :archives, :rejected].include?(advert.try(:state).try(:to_sym)) && advert.try(:user) == user
        end
        can :destroy, Advert do |advert|
          advert.try(:user) == user
        end
        can :update, User do |u|
          u == user
        end
        can :read, User
      elsif can :read, Advert do |advert|
        advert.try(:state_is?, :published)
      end
      end
    end
  end
end
