require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) {FactoryGirl.create :comment}
  it {expect(subject).to belong_to(:task)}
  it {expect(subject).to validate_presence_of(:body)}
  it {expect(subject).to validate_presence_of(:task)}
end
