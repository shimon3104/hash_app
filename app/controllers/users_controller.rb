class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]

  def show
    notes = Note.where(user_id: current_user.id)
    @notes = notes.order(created_at: :desc)
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if current_user.update(user_params)
      sign_in(current_user, bypass: true)
      redirect_to root_path
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password)
  end
end
