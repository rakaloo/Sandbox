module ArticlesHelper
	def current_version(article)
		article.versions.last
	end
end
