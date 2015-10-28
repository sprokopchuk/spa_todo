module SetupHelper
  def setup user
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability).and_return @ability
  end

  def setup_omniauth user
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: user.uid,
        info: {
          name: Faker::Name.name,
          email: user.email
        },
        credentials: {
          token: "123456",
          expires_at: Time.now + 1.week
        }
    })
  end

  # login_as helper don't work
  def login user
    visit "/#/login"
    within "#loginform" do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find_button("Log In").click
    end
  end


end
