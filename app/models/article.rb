class Article < ApplicationRecord
	has_many :categorizations
	has_many :categories, through: :categorizations
	has_many :versions
	has_many :editors, through: :versions, source: :editor
end
