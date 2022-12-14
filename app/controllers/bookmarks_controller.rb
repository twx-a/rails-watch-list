class BookmarksController < ApplicationController
  before_action :set_list, only: %i[new create]
  def new
    @bookmark = Bookmark.new
  end

  def create
    # raise
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    # raise
    if @bookmark.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.update(bookmark_params)
    redirect_to list_path(@bookmark.list)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
