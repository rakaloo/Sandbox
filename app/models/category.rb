class Category < ApplicationRecord
  has_many :categorizations
  has_many :articles, through: :categorizations

  validates :name, { presence: true, uniqueness: true }
end
