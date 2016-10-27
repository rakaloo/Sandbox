class CategoriesController < ApplicationController
  def create
  end

  def update
  end

  def destroy
  end

  def show
    @category = Category.find(params[:id])
  end
end
