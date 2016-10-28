class Categorization < ApplicationRecord
  belongs_to :article
  belongs_to :category

  validates_uniqueness_of :category, :scope => :article
end
