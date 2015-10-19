require 'rails_helper'

feature 'User authentication', js: true do

  given!(:user) {FactoryGirl.create :user}

  scenario 'log in' do
    visit "/#/login"
    within "#loginform" do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
    end
    click_button "Welcome, User!"
    expect(page).to have_link("Log Out!")
  end

  scenario 'register' do
    visit "/#/register"
    within "#registrationform" do
      fill_in "Email", with: Faker::Internet.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password
      click_button "Register"
    end
    click_button "Welcome, User!"
    expect(page).to have_link("Log Out!")
  end

  scenario 'log out' do
    login user
    visit "/#/projects"
    click_button "Welcome, User!"
    click_link "Log Out!"
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
      click_button "Welcome, User!"
      expect(page).to have_link("Log Out!")
    end
  end


end
