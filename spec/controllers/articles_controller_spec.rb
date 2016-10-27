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
end
