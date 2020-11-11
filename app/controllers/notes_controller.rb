class NotesController < ApplicationController
  def index
 
  end

  def new
    @note= NotesTag.new
  end

  def create
    @note = NotesTag.new(note_params)
    if @note.valid?
      @note.save
      return redirect_to user_path(@note.user_id)
    else
      render "new"
    end
  end

  private
  def note_params
    params.require(:notes_tag).permit(:title, :text, :name).merge(user_id: current_user.id)
  end
end
