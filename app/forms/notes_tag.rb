class NotesTag

  include ActiveModel::Model
  attr_accessor :title, :text, :user_id, :name
  with_options presence: true do
    validates :title
    validates :title
    validates :name
  end

  def save
    note = Note.create(title: title, text: text, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    NoteTagRelation.create(note_id: note.id, tag_id: tag.id)
  end

  # def update
    
  #   note = Note.find(params[:id])
    
  #   tag = Tag.where(name: name).first_or_initialize
  #   tag.save
  #   note = NoteTagRelation.find(tag.id)
  #   note.update(note_id: note_update.id, tag_id: tag.id)
  #   note_update = note.update(title: title, text: text)
  # end

end