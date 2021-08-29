class CategoriesController < ApplicationController

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
     redirect_back(fallback_location root_path)
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
    else
      redirect_back(fallback_location root_path)
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path
    else
      redirect_back(fallback_location root_path)
    end
  end

  def search
    @category_word = params[:category_word]
    @books = Category.find_by(name: @category_word).books
    @user = current_user
    @book = Book.new
    @categories = Category.all
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
