class NotesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :publish]
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @note= NotesTag.new
    notes = Note.where(user_id: current_user.id)
    @notes = notes.order(created_at: :desc)
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
    @notes = Note.order('created_at DESC')
    unless @note.公開する?
      authenticate_user!
    end
  end

  def edit
    notes = Note.where(user_id: current_user.id)
    @notes = notes.order(created_at: :desc)
    tag_name = []
    @note.tags.each do |tag|
      tag_n = tag.name
      tag_name.push(tag_n)
    end
    @tag_names = tag_name.join(',')
    @note_tag = NotesTag.new(title: @note.title, text: @note.text, status: @note.status, user_id: @note.user_id, name: @tag_names)
  end

  def update
    @note.destroy
    @note_tag = NotesTag.new(note_tag_params)
    if @note_tag.valid?
      @note_tag.save
      return redirect_to user_path(@note.user_id)
    else
      render "edit"
    end
  end

  def destroy
    @note.destroy
    redirect_to user_path(@note.user_id)
  end

  def publish
    @notes = Note.order('created_at DESC')
  end

  def search_title
    @search_notes = Note.search_title(params[:keyword])
  end

  def search_text
    @search_notes = Note.search_title(params[:keyword])
  end

  def search_title_user
    @search_notes = Note.search_title(params[:keyword])
    notes = Note.where(user_id: current_user.id)
    @notes = notes.order(created_at: :desc)
  end

  def search_text_user
    @search_notes = Note.search_title(params[:keyword])
    notes = Note.where(user_id: current_user.id)
    @notes = notes.order(created_at: :desc)
  end

  private
  def note_tag_params
    params.require(:notes_tag).permit(:title, :text, :status, :name).merge(user_id: current_user.id)
  end
  
  def set_note
    @note = Note.find(params[:id])
  end

  def move_to_index
    unless @note.user_id == current_user.id
      redirect_to root_path
    end
  end
end
