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

  describe "post #create" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let!(:article) { Article.create! }

    it "responds with status code 302" do
      post :create, { params: { article_id: article.id, version: {title: "Test Title", body: "Test Body", editor_id: user.id } } }, sign_in(user)
      expect(response).to have_http_status 302
    end

    it "passes through the article found to be shown as @article" do
      post :create, { params: { article_id: article.id, version: {title: "Test Title", body: "Test Body", editor_id: user.id } } }, sign_in(user)
      expect(assigns(:article)).to be_a Article
    end

    it "creates a new version in the database" do

      expect{ post :create, { params: { article_id: article.id, version: {title: "Test Title", body: "Test Body", editor_id: user.id } } }, sign_in(user) } .to change{Version.all.count}.by 1
    end

    it "assigns the newly created version as @version" do
      post :create, { params: { article_id: article.id, version: {title: "Test Title", body: "Test Body", editor_id: user.id } } }, sign_in(user)
      expect(assigns(:version)).to eq Version.last
    end

    it "redirects to the article that the version is associated with" do
      post :create, { params: { article_id: article.id, version: {title: "Test Title", body: "Test Body", editor_id: user.id } } }, sign_in(user)
      expect(response).to redirect_to article_path(Article.last)
    end
  end

  describe "delete #destroy" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let!(:admin) { User.create(username: "Ellie", email:"ellie@ellie.com", password: "password", role: "Admin") }
    let!(:article) { Article.create! }
    let (:versions) { [Version.create(title: "it's the first test title", body: "it's the first test body", article: article, editor: user ) ]}

    context "when admin is the user trying to destroy a version" do
      it "responds with status code 302" do
        delete :destroy, { :params => { article_id: article.id, id: versions[0].id } }, sign_in(admin)
        expect(response).to have_http_status 302
      end

      it "destroys an version" do
        expect{ delete :destroy, { :params => { article_id: article.id, id: versions[0].id } }, sign_in(admin) } .to change{Version.all.count}.by -1
      end

      it "destroys the specific version" do
        delete :destroy, { :params => { article_id: article.id, id: versions[0].id } }, sign_in(admin)
        expect(Version.pluck(:id)).not_to include(versions[0].id)
      end
    end

    context "when user is trying to destroy a version" do#
     it "responds with 422 public rejection file" do
      delete :destroy, { :params => { article_id: article.id, id: versions[0].id } }, sign_in(user)
      expect(response).to render_template(:file => "#{Rails.root}/public/422.html")
      end
    end
  end
end


