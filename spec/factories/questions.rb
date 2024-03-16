FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "title_#{n}"}
    sequence(:content) {"aaaaaaaaaaaa"}
    association :user
  end
end
