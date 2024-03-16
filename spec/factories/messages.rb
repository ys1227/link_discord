FactoryBot.define do
  factory :message do
    content { 'aaaaaaaaaa' }
    association :user
    association :question
  end
end
