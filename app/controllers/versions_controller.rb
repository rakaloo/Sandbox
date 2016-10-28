class VersionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@article = Article.find_by(id: params[:article_id])
		@versions = @article.versions
	end

	def show
		@version = Version.find_by(id: params[:id])
	end

	def new
		@article = Article.find_by(id: params[:article_id])
	end

	def create
		@article = Article.find_by(id: params[:article_id])
		@version = Version.create(version_params.merge(editor: current_user, article: @article))
		p @version.errors.full_messages
		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find_by(id: params[:article_id])
		Version.find_by(id: params[:id]).destroy
		redirect_to article_path(@article)
	end

	private
		def version_params
			params.require(:version).permit(:title, :body)
		end
end
