require 'rails_helper'

RSpec.describe Project, type: :model do
  subject {FactoryGirl.create :project}
  it {expect(subject).to belong_to(:user)}
  it {expect(subject).to have_many(:tasks)}
  it {expect(subject).to validate_presence_of(:name)}
  it {expect(subject).to validate_presence_of(:user)}
end
