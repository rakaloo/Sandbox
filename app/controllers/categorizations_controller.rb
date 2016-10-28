class CategorizationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @categorization = Categorization.create(article_id: params[:article_id], category_id: params[:category][0])
  end

  def destroy
    Categorization.find_by(id: params[:id]).destroy
  end
end
