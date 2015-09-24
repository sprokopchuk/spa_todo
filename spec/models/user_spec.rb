require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create :user}
  it {expect(subject).to have_many(:projects)}
end
