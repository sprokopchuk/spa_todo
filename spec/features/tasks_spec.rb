require 'rails_helper'

feature 'Tasks managment', js: true do
  given!(:user) {FactoryGirl.create :user}
  given!(:project) {FactoryGirl.create :project, user: user}
  given!(:task) {FactoryGirl.create :task, project: project}

  background do
    login user
  end

  scenario 'adding task' do
    fill_in "task", with: "My task"
    click_button "Add task"
    expect(page).to have_content("My task")
  end

  scenario 'change name of task' do
    click_link "editTask_#{task.id}"
    within "div.editable-controls" do
      find("input.editable-input").set 'New task'
      find("button.btn-success").click
    end
    expect(page).to have_content "New task"
  end

  scenario "set status of task is done" do
    checkbox = find('input[type="checkbox"]')
    checkbox.click
    expect(checkbox.checked?).to be_truthy
  end

  scenario 'delete task' do
    within "li.list-group-item" do
      find("a.trash").click
    end
    expect(page).not_to have_content(task.name)
  end

end
