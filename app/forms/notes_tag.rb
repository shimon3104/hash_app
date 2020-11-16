class NotesTag

  include ActiveModel::Model
  attr_accessor :title, :text, :user_id, :status, :name
  with_options presence: true do
    validates :title
    validates :title
    validates :name
  end

  def save
    note = Note.create(title: title, text: text, user_id: user_id, status: status)
    tag_list = name.split(",")
    tag_list.each do |tag_name|
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save
      NoteTagRelation.create(note_id: note.id, tag_id: tag.id)
    end
  end

end