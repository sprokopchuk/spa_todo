require 'rails_helper'

feature 'Comments managment', js: true do
  given!(:user) {FactoryGirl.create :user}
  given!(:project) {FactoryGirl.create :project, user: user}
  given!(:task) {FactoryGirl.create :task, project: project}
  given!(:comment) {FactoryGirl.create :comment, task: task}

  background do
    login user
  end

  scenario 'adding comment' do
    within "div.action-button" do
      find("a.comment").click
    end
    fill_in "comment", with: "My new comment"
    find_button("Add Comment").click
    expect(page).to have_content("My new comment")
  end

  scenario 'delete comment' do
    find("a.trash.comment").click
    expect(page).not_to have_content(comment.body)
  end

end
