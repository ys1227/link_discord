FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "title_#{n}"}
    sequence(:content) {"aaaaaaaaaaaa"}
    role { "inquiry" }
    state { "published" }

    association :user

    trait :past do
      created_at { DateTime.now.ago(1.hours) }
    end

    trait :with_reservation do 
      transient do
        sequence(:start_time) { Time.current + 48.hours }
        sequence(:rank) { 'default' }
      end

      after(:create) do |question, evaluator|
        create(:reservation, start_time: evaluator.start_time, rank: evaluator.rank, question: question)
      end
    end
  end
end
