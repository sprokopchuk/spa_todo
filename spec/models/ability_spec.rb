require 'rails_helper'
require "cancan/matchers"
RSpec.describe Ability, type: :model do
  describe "abilities of user" do
    let(:user) {FactoryGirl.create :user}
    subject {Ability.new(user)}
    context "for projects" do
    end

    context "for tasks" do
    end

    context "for comments" do
    end

    context "for attachment"
  end
end
