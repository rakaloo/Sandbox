class CategorizationsController < ApplicationController

  def create
    @categorization = Categorization.create(article_id: params[:article_id], category_id: params[:category][0])
  end

end
