class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is? Role.admin_role
      admin_ability user
    elsif user.is? Role.user_role
      user_ability user
    end
    guest_ability
  end

  def guest_ability
    can :read, Advert do |advert|
      advert.try(:state_is?, :published)
    end
    can :personal_locale, Advert
    can :search, Advert
  end

  def user_ability(user)
    can :read, :all
    can :create, Advert
    can :manage, :person
    can :destroy, User do |u|
      user == u
    end
    can :update, Advert do |advert|
      [:draft, :archives, :rejected].include?(advert.try(:state).try(:to_sym)) && advert.try(:user) == user
    end
    can :destroy, Advert do |advert|
      advert.try(:user) == user
    end
    can :update, User do |u|
      u == user
    end
    can :read, User do |u|
      u == user
    end
    can :profile , :person
  end

  def admin_ability user
    user_ability user
    can :read, :all
    can [:approve, :reject, :reject_reason], Advert do |advert|
      advert.try(:state_is?, :new)
    end
    can :manage, User
    can :nonpublished, Advert
    can :approve_all, Advert
    can :destroy, Advert
    can [:assign_roles, :edit, :create, :destroy], User
    can :create, Type
    can :destroy, Type do |t|
      t.adverts.empty?
    end

    cannot [:edit, :create], Advert

  end
end
