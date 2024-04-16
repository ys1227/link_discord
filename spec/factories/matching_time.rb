FactoryBot.define do
  factory :matching_time do
    matching_data { DateTime.now + 48.hours }
    association :question
    association :reservation
  end
end
