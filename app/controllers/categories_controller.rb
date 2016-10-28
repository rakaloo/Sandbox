class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_if_banned

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      @errors = @category.errors.full_messages
      redirect_to new_article_path
    end
  end

  def update
  end

  def destroy
    if admin_user?
      category = Category.find(params[:id])
      category.destroy
      redirect_to categories_path
    else
      render file: "/public/422.html"
    end
  end

  def show
    @category = Category.find(params[:id])
  end

private
  def category_params
    params.require(:category).permit(:name)
  end
end
