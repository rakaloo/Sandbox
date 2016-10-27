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
    it "responds with status code 200" do
      get :new
      expect(response).to have_http_status 200
    end

    it "assigns a new article to @article" do
      get :new
      expect(assigns(:article)).to be_a_new Article
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when valid params are passed, which is impossible to do right now for article" do
      it "responds with status code 302" do
        post :create
        expect(response).to have_http_status 302
      end

      it "creates a new article in the database" do
        expect{ post :create } .to change{Article.all.count}.by 1
      end

      it "assigns the newly created article as @article" do
        post :create
        expect(assigns(:article)).to eq Article.last
      end

      it "redirects to the created article" do
        post :create
        expect(response).to redirect_to article_path(Article.last)
      end
    end
	end
end
