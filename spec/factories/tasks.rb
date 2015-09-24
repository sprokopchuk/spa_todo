FactoryGirl.define do
  factory :task do
    name {Faker::Lorem.sentence}
    deadline {Faker::Time.between(DateTime.now - 1, DateTime.now)}
    priority 1
    project
  end

end
