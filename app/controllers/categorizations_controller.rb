class CategorizationsController < ApplicationController

  def create
    @categorization = Categorization.create(categorization_params)
  end

private
  def categorization_params
    params.require(:categorization).permit(:article_id, :category_id, :article, :category)
  end
end
