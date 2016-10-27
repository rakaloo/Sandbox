class Article < ApplicationRecord
	has_many :categorizations
	has_many :categories, through: :categorizations
	has_many :versions
	has_many :editors, through: :versions, source: :editor

	def current_version
		versions.last
	end
end
