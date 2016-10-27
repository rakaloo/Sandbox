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


end
