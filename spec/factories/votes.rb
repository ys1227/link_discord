FactoryBot.define do
  factory :vote do
    association :user
    association :reservation
  end
end
