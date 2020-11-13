class NotesController < ApplicationController
  def index
 
  end

  def new
    @note= NotesTag.new
  end

  def create
    @note = NotesTag.new(note_tag_params)
    if @note.valid?
      @note.save
      return redirect_to user_path(@note.user_id)
    else
      render "new"
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
    tag = NoteTagRelation.find_by(note_id: @note.id)
    @tag = Tag.find(tag.tag_id)
    @note_tag = NotesTag.new(title: @note.title, text: @note.text, user_id: @note.user_id, name: @tag.name)
  end

  def update
    note = Note.find(params[:id])
    note.destroy
    @note_tag = NotesTag.new(note_tag_params)
    if @note_tag.valid?
      @note_tag.save
      return redirect_to user_path(note.user_id)
    else
      render "edit"
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to user_path(@note.user_id)
  end

  private
  def note_tag_params
    params.require(:notes_tag).permit(:title, :text, :name).merge(user_id: current_user.id)
  end
  
end
