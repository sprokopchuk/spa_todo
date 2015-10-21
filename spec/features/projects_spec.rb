require 'rails_helper'

feature 'Projects managment', js: true do
  given!(:user) {FactoryGirl.create :user}
  given!(:project) {FactoryGirl.create :project, user: user}

  background do
    login user
    visit "/#/projects"
  end

  scenario 'adding the project' do
    click_button "Add TODO List"
    fill_in "nameProject", with: "New project"
    click_button "Add project"
    expect(page).to have_content("New project")
  end

  scenario 'delete project' do
    click_link "deleteProject_#{project.id}"
    expect(page).not_to have_content(project.name)
  end

  scenario 'update name of project' do
    click_link "editProject_#{project.id}"
    first(:xpath, '//input[@type="text"]').set "My project"
    first(:xpath, '//button[@type="submit"]').click
    expect(page).to have_content "My project"
  end

end
