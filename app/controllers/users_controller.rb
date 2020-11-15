class UsersController < ApplicationController

  def show
    @notes = Note.all.order(created_at: :desc)
  end

  def edit
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
