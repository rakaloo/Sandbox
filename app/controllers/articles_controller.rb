class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@articles = Article.all
	end

	def create
		@article = Article.create
		redirect_to @article
	end

	def new
		p current_user
		@article = Article.new
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
end
