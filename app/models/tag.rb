class Tag < ApplicationRecord
  has_many :note_tag_relations, dependent: :destroy
  has_many :notes, through: :note_tag_relations

  validates :name, presence: true, uniqueness: { case_sensitive: true }

  def self.search(search)
    if search != ""
      Tag.where('name LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Tag.order('created_at DESC')
    end
  end
end
