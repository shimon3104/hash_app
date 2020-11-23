FactoryBot.define do
  factory :notes_tag do
    title  { Faker::Lorem.characters(number: 50, min_numeric: 1) }
    text { Faker::Lorem.sentence }
    name { Faker::Lorem.sentence }
  end
end
