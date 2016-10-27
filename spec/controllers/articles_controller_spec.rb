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
end
