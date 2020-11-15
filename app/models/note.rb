class Note < ApplicationRecord
  belongs_to :user
  has_many :note_tag_relations, dependent: :destroy
  has_many :tags, through: :note_tag_relations
  accepts_nested_attributes_for :note_tag_relations, allow_destroy: true
  enum status:{非公開: 0, 公開する: 1}
end
