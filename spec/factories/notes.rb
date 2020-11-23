FactoryBot.define do
  factory :note do
    title  { Faker::Lorem.characters(number: 50, min_numeric: 1) }
    text { Faker::Lorem.sentence }
    association :user
  end
end
