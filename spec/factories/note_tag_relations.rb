FactoryBot.define do
  factory :note_tag_relation do
    association :note
    association :tag
  end
end
