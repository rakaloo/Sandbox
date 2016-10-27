class Article < ApplicationRecord
	has_many :categorizations
	has_many :categories, through: :categorizations
	has_many :versions
	has_many :editors, through: :versions, source: :editor

	accepts_nested_attributes_for :versions

	def current_version
		versions.last
	end
end
