class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user
      can [:read, :create, :destroy, :update], Project, :user_id => user.id
      can [:read, :create, :destroy, :update], Task, :project => { user_id: user.id }
      can [:read, :create, :destroy, :update, :attach_file], Comment, :task => {project: {user_id: user.id }}
    end
  end
end
