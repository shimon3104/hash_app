class NotesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :publish, :search_title, :search_text ]
  before_action :set_note, only: [:edit, :show, :update, :destroy]
  before_action :set_notes, only: [:new, :edit, :search_title_user, :search_text_user, :search_tag_user]
  before_action :set_keyword, only: [:search_title, :search_text, :search_title_user, :search_text_user, :search_tag_user]
  before_action :move_to_index, only: [:edit, :update, :destroy]

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
    @notes = Note.order('created_at DESC')
    unless @note.公開する?
      authenticate_user!
    end
  end

  def edit
    tag_name = []
    @note.tags.each do |tag|
      t_name = tag.name
      tag_name.push(t_name)
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
    @search_notes = Note.search_text(params[:keyword])
  end

  def search_title_user
    @search_notes = Note.search_title_user(params[:keyword])
  end

  def search_text_user
    @search_notes = Note.search_text_user(params[:keyword])
  end

  def search_tag_user
    @search_tags = Note.search_tag_user(params[:keyword])
  end

  private
  def note_tag_params
    params.require(:notes_tag).permit(:title, :text, :status, :name).merge(user_id: current_user.id)
  end
  
  def set_note
    if Note.find_by(id: params[:id]).nil?
      return redirect_to root_path
    else
      @note = Note.find(params[:id])
    end
  end

  def set_notes
    notes = Note.where(user_id: current_user.id)
    @notes = notes.order(created_at: :desc)
  end

  def set_keyword
    @keyword = params[:keyword]
  end

  def move_to_index
    unless @note.user_id == current_user.id
      redirect_to root_path
    end
  end
end
