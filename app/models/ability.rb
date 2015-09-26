class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user
      can [:read, :create, :destroy, :update], Project, :user_id => user.id
      can :manage, Task, :project => { user_id: user.id }
      can :manage, Comment, :task => {project: {user_id: user.id }}
    end
  end
end
