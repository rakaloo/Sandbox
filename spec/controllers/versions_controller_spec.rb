require 'rails_helper'

RSpec.describe VersionsController, type: :controller do

  describe "GET #index" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let!(:article) { Article.create! }
    let (:versions) { [Version.create(title: "it's the first test title", body: "it's the first test body", article: article, editor: user ), Version.create(title: "it's second test title", body: "it's  second test body", article: article, editor: user)] }

    it "responds with status code 200" do
      get :index, { params: { article_id: article.id } }
      expect(response).to have_http_status 200
    end

    it "passes through the article found as @article" do
      get :index, { params: { article_id: article.id } }
      expect(assigns(:article)).to be_a Article
    end

    it "passes through the versions to the template as @versions" do
      get :index, { params: { article_id: article.id } }
      expect(assigns(:versions)).to all be_a Version
    end

    it "renders the :new template" do
      get :index, { params: { article_id: article.id } }
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let!(:article) { Article.create! }
    let (:versions) { [Version.create(title: "it's the first test title", body: "it's the first test body", article: article, editor: user ), Version.create(title: "it's second test title", body: "it's  second test body", article: article, editor: user)] }

    it "responds with status code 200" do
      get :show, { params: { article_id: article.id, id: versions[0].id } }
      expect(response).to have_http_status 200
    end

    it "passes through the version found to be shown as @version" do
      get :show, { params: { article_id: article.id, id: versions[0].id } }
      expect(assigns(:version)).to be_a Version
    end

    it "renders the :show template" do
      get :show, { params: { article_id: article.id, id: versions[0].id } }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let!(:article) { Article.create! }

    it "responds with status code 200" do
      get :new, { params: { article_id: article.id } }, sign_in(user)
      expect(response).to have_http_status 200
    end

    it "passes through the article found to be shown as @article" do
      get :new, { params: { article_id: article.id } }, sign_in(user)
      expect(assigns(:article)).to be_a Article
    end

    it "renders the :new template" do
      get :new, { params: { article_id: article.id } }, sign_in(user)
      expect(response).to render_template(:new)
    end
  end
end
