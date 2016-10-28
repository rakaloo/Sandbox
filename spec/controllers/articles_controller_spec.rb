require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

	describe "GET #index" do
    it "responds with status code 200" do
      get :index
      expect(response).to have_http_status 200
    end

    it "passes through all the articles as @articles" do
      get :index
      expect(assigns(:articles)).to all be_a Article
    end

    it "renders the :new template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
  	let!(:article) { Article.create! }

    it "responds with status code 200" do
      get :show, { id: article.id }
      expect(response).to have_http_status 200
    end

    it "findsthrough all the articles as @articles" do
      get :show, { id: article.id }
      expect(assigns(:article)).to be_a Article
    end

    it "finds the article based off the id param" do
      get :show, { id: article.id }
      expect((assigns(:article)).id).to eq article.id
    end

    it "renders the :new template" do
      get :show, { id: article.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
  	let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    it "responds with status code 200" do
      get :new, {}, sign_in(user)
      expect(response).to have_http_status 200
    end

    it "assigns a new article to @article" do
      get :new, {}, sign_in(user)
      expect(assigns(:article)).to be_a_new Article
    end

    it "renders the :new template" do
      get :new, {}, sign_in(user)
      expect(response).to render_template(:new)
    end
  end

	describe "POST #create" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let!(:banned) { User.create(username: "Pete", email:"Pete@pete.com", password: "password", role: "Banned") }
    let (:versions) { [Version.create(title: "it's the first test title", body: "it's the first test body", article: article, editor: user ), Version.create(title: "it's second test title", body: "it's  second test body", article: article, editor: user)] }

	    context "when valid params are passed, creates an article" do
	      it "responds with status code 302" do
	        post :create, {}, sign_in(user)
	        expect(response).to have_http_status 302
	      end

	      it "creates a new article in the database" do
         post :create, {}, sign_in(user)
	        expect{ post :create } .to change{Article.all.count}.by 1
	      end

	      it "assigns the newly created article as @article" do
	        post :create, {}, sign_in(user)
	        expect(assigns(:article)).to eq Article.last
	      end

	      it "redirects to the created article" do
	        post :create, {}, sign_in(user)
	        expect(response).to redirect_to article_path(Article.last)
	      end

        it "redirects a banned user" do
          post :create, {}, sign_in(banned)
          expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
        end
	    end
  end

  describe "delete #destroy" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let!(:admin) { User.create(username: "Ellie", email:"ellie@ellie.com", password: "password", role: "Admin") }
    let!(:space_article) { Article.create! }
    let!(:article) { Article.create! }

    context "when admin is the user trying to destroy a post" do
      it "responds with status code 302" do
        delete :destroy, { id: article.id }, sign_in(admin)
        expect(response).to have_http_status 302
      end

      it "destroys an article" do
        expect{ delete :destroy, { id: article.id }, sign_in(admin) } .to change{Article.all.count}.by -1
      end

      it "destroys the specificarticle" do
        delete :destroy, { id: article.id }, sign_in(admin)
        expect(Article.pluck(:id)).not_to include(article.id)
      end
    end

    context "when user is trying to destroy a post" do#
     it "responds with 422 public rejection file" do
      delete :destroy, { id: article.id }, sign_in(user)
      expect(response).to render_template(:file => "#{Rails.root}/public/422.html")
      end
    end
	end
end
