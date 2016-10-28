class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :search]
	before_action :check_if_banned

	def index
		@articles = Article.all
	end

	def create
		@article = Article.new(article_params)
		@article.versions[0].editor = current_user
		@article.save
		if params[:category]
			params[:category].each do |category_id|
				Categorization.create(article: @article, category_id: category_id)
			end
		end
		redirect_to @article
	end

	def new
		@article = Article.new
		@article.versions.build
		@article.categorizations.build
	end

	def show
		@article = Article.find_by(id: params[:id])
	end

	def destroy
		if admin_user?
			Article.find_by(id: params[:id]).destroy
			redirect_to articles_path
		else
			render file: "/public/422.html"
		end
	end

	def search
		@potential_matches = Article.all.map do |article|
			article.versions.last
		end
		search_term = params[:search].downcase
		@title_matches = @potential_matches.select { | version | version.title.downcase.include? search_term}
		@body_matches = @potential_matches.select { | version | version.body.downcase.include? search_term}
	end

	private
		def article_params
			params.require(:article).permit(versions_attributes: [:title, :body])
		end

end
