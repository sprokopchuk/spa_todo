require 'rails_helper'

RSpec.describe Task, type: :model do
  subject {FactoryGirl.create :task}
  it {expect(subject).to belong_to(:project)}
  it {expect(subject).to validate_presence_of(:name)}
  it {expect(subject).to validate_presence_of(:priority)}
  it {expect(subject).to validate_presence_of(:project)}
  it {expect(subject).to have_many(:comments)}
end
