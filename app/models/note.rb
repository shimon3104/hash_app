class Note < ApplicationRecord
  belongs_to :user
  has_many :note_tag_relations
  has_many :tags, through: :note_tag_relations
  has_one :publish

  with_options presence: true do
    validates :title
    validates :text
  end
end
