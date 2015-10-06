module SetupHelper
  def setup user
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability).and_return @ability
  end
end
