FactoryBot.define do
  factory :note do
    title  { Faker::Lorem.characters(number: 50, min_numeric: 1) }
    text { Faker::Lorem.sentence }
    status { '非公開' }
    association :user

    trait :note_with_tags do
      status { '公開する' }
      after(:build) do |note|
        note.tags << build(:tag, name: 'test')
      end
    end

    trait :note2_with_tags do
      after(:build) do |note|
        note.tags << build(:tag, name: 'test2')
      end
    end
  end
end
