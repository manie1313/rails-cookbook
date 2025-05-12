class BookmarksController < ApplicationController
  before_action :set_category, only: %i[new create]

  def new
    @bookmark = Bookmark.new
    @recipes = Recipe.all.order(:name)
  end
  # A user can add a new recipe to an existing category
  # by creating a new bookmark (recipe/category pair) here ⇒
  # 'categories/42/bookmarks/new'

  def create
    # raise
    @bookmark = Bookmark.new(strong_params)
    @bookmark.category = @category
    if @bookmark.save
      redirect_to category_path(@category)
    else
      @recipes = Recipe.all.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
  end

  private

  def strong_params
    params.require(:bookmark).permit(:recipe_id, :comment)
  end

  def set_category
     @category = Category.find(params[:category_id])
  end
end
