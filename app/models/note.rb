class Note < ApplicationRecord
  belongs_to :user
  has_many :note_tag_relations, dependent: :destroy
  has_many :tags, through: :note_tag_relations
  accepts_nested_attributes_for :note_tag_relations, allow_destroy: true
  enum status:{非公開: 0, 公開する: 1}

  with_options presence: true do
    validates :title,length: { maximum: 50, message: 'is too long (maximum is 50 characters)' }
    validates :text
  end

  
  def self.search_title(search)
    if search != ""
      Note.where('title LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Note.order('created_at DESC')
    end
  end

  def self.search_text(search)
    if search != ""
      Note.where('text LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Note.order('created_at DESC')
    end
  end


  def self.search_title_user(search)
    if search != ""
      Note.where('title LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Note.order('created_at DESC')
    end
  end

  def self.search_text_user(search)
    if search != ""
      Note.where('text LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Note.order('created_at DESC')
    end
  end

  def self.search_tag_user(search)
    if search != ""
      Tag.where('name LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Tag.order('created_at DESC')
    end
  end
end
