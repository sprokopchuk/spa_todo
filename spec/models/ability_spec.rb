require 'rails_helper'
require "cancan/matchers"
RSpec.describe Ability, type: :model do
  describe "abilities of user" do
    let(:user) {FactoryGirl.create :user}
    let(:project) {FactoryGirl.create :project, user: user}
    subject {Ability.new(user)}
    context "for projects" do
      let(:other_project) {FactoryGirl.create :project}
      it {expect(subject).to be_able_to(:read, project)}
      it {expect(subject).to be_able_to(:update, project)}
      it {expect(subject).to be_able_to(:create, Project)}
      it {expect(subject).to be_able_to(:destroy, project)}
      it {expect(subject).not_to be_able_to(:read, other_project)}
      it {expect(subject).not_to be_able_to(:update, other_project)}
      it {expect(subject).not_to be_able_to(:destroy, other_project)}
    end

    context "for tasks" do
      let(:task) {FactoryGirl.create :task, project: project}
      let(:other_task) {FactoryGirl.create :task}
      it {expect(subject).to be_able_to(:read, task)}
      it {expect(subject).to be_able_to(:update, task)}
      it {expect(subject).to be_able_to(:create, Task)}
      it {expect(subject).to be_able_to(:destroy, task)}
      it {expect(subject).not_to be_able_to(:read, other_task)}
      it {expect(subject).not_to be_able_to(:update, other_task)}
      it {expect(subject).not_to be_able_to(:destroy, other_task)}
    end

    context "for comments" do
      let(:task) {FactoryGirl.create :task, project: project}
      let(:comment) {FactoryGirl.create :comment, task: task}
      let(:other_comment) {FactoryGirl.create :comment}
      it {expect(subject).to be_able_to(:read, comment)}
      it {expect(subject).to be_able_to(:update, comment)}
      it {expect(subject).to be_able_to(:create, Comment)}
      it {expect(subject).to be_able_to(:destroy, comment)}
      it {expect(subject).not_to be_able_to(:read, other_comment)}
      it {expect(subject).not_to be_able_to(:update, other_comment)}
      it {expect(subject).not_to be_able_to(:destroy, other_comment)}
    end

    context "for attachment"
  end
end
