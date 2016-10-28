class Article < ApplicationRecord
	has_many :categorizations
	has_many :categories, through: :categorizations
	has_many :versions
	has_many :editors, through: :versions, source: :editor

	accepts_nested_attributes_for :versions
  accepts_nested_attributes_for :categorizations

	def current_version
		versions.last
	end

  def cached_body
    versions[-2].body
  end

  def cached_title
    versions[-2].title
  end

  def editor
    current_version.editor
  end

  def edit_count
    versions.count
  end

  def last_updated_by
    editor.username
  end

  def last_updated_at
    current_version.updated_at.to_date
  end
end
