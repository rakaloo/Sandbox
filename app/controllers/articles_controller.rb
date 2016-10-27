class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@articles = Article.all
	end

	def create
		@article = Article.new(article_params)
		@article.versions[0].editor = current_user
		@article.save
		redirect_to @article
	end

	def new
		@article = Article.new
		@article.versions.build
	end

	def show
		@article = Article.find_by(id: params[:id])
	end

	def destroy
		if current_user && current_user.role == "Admin"
			Article.find_by(id: params[:id]).destroy
			redirect_to articles_path
		else
			render file: "/public/422.html"
		end
	end

	private
		def article_params
			params.require(:article).permit(versions_attributes: [:title, :body])
		end
end
