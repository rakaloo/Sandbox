module ArticlesHelper
	def article_blurb(article)
		article.current_version.body.gsub(/(<img).*>/, "")[0..200].html_safe
	end
end
