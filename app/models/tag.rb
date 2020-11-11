class Tag < ApplicationRecord
  has_many :note_tag_relations
  has_many :notes, through: :note_tag_relations

  validates :name, presence: true
end
