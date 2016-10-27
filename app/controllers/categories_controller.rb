class CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)
    @category.save
  end

  def update
  end

  def destroy
    if current_user && current_user.role == "Admin"
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