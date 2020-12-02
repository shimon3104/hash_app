FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.sentence }

    # sequence(:name) { |n| "test_note#{n}" }
  end
end
