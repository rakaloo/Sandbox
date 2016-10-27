class CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)
    @category.save
  end

  def update
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to catergories_path
  end

  def show
    @category = Category.find(params[:id])
  end

private
  def category_params
    params.require(:category).permit(:name)
  end
end
