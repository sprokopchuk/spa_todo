class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user
      can :manage, Project, :user_id => user.id
      can :manage, Task, :user_id => user.id
    end
  end
end
