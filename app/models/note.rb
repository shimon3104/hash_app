class Note < ApplicationRecord
  belongs_to :user
  has_many :note_tag_relations, dependent: :destroy
  has_many :tags, through: :note_tag_relations
  accepts_nested_attributes_for :note_tag_relations, allow_destroy: true
  has_one :publish
  enum status:{nonreleased: 0, released: 1}
end
