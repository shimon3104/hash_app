class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
  end

  def search
    @tags = Tag.search(params[:keyword])
    @keyword = params[:keyword]
  end
end
