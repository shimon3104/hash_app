class Tag < ApplicationRecord
  has_many :note_tag_relations, dependent: :destroy
  has_many :notes, through: :note_tag_relations

  validates :name, uniqueness: true

  def self.search(search)
    if search != ""
      Tag.where('name LIKE(?)', "%#{search}%")
    else
      Tag.all
    end
  end
end
