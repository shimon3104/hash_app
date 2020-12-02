class TagsController < ApplicationController
  def show
    if Tag.find_by(id: params[:id]).nil?
      redirect_to root_path
    else
      @tag = Tag.find(params[:id])
    end
  end

  def search
    @tags = Tag.search(params[:keyword])
    @keyword = params[:keyword]
  end
end
