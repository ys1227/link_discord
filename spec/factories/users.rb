FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    sequence(:uid) { |n| "#{n}"}

    trait :past do
      created_at { DateTime.now.ago(1.hours) }
    end

    trait :future do
      created_at { DateTime.now.since(1.hours) }
    end
  end
end
