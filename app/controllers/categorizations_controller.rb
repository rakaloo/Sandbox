class CategorizationsController < ApplicationController

  def create
    @categorization = Categorization.create(categorization_params)
  end

private
  def categorization_params
    params.require(:categorization).permit(:article, :category)
  end
end
