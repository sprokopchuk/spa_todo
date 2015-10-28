require 'rails_helper'

feature 'User authentication', js: true do

  given(:user) {FactoryGirl.create :user}

  scenario 'log in' do
    visit "/#/login"
    within "#loginform" do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find_button("Log In").click
    end
    expect(page).to have_button("Log Out!")
  end

  scenario 'register' do
    visit "/#/register"
    within "#registrationform" do
      fill_in "Email", with: Faker::Internet.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password
      find_button("Register").click
    end
    expect(page).to have_button("Log Out!")
  end

  scenario 'log out' do
    login user
    find_button("Log Out!").click
    expect(page).to have_button "Log In"
  end

 feature 'log in via Facebook' do
    given!(:user_with_facebook_account) {FactoryGirl.create :user, uid: 1234567, provider: "facebook"}
    background do
      visit "/#/login"
      setup_omniauth user_with_facebook_account
    end
    scenario 'log in' do
      click_link "Login with Facebook"
      expect(page).to have_button("Log Out!")
    end
  end


end
