FactoryBot.define do
  factory :reservation do
    start_time { Time.current + 48.hours }
    rank {'default'}
    association :question
  end
end
