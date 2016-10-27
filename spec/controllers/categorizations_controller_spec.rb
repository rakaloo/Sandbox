require 'rails_helper'

RSpec.describe CategorizationsController, type: :controller do

  describe "POST #create" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let (:article) { Article.create}
    let (:category) { Category.create(name: "Clouds") }

      context "when valid params are passed, the categorization is created" do

        it "creates a new categorization in the database" do
          expect {post :create, { params: { categorization: { article_id: article.id, category_id: category.id } } }, sign_in(user) }.to change{Categorization.all.count}.by 1
        end

        it "assigns the newly created category as @categorization" do
          post :create, { params: { categorization: { article_id: article.id, category_id: category.id } } }, sign_in(user)
          expect(assigns(:categorization)).to eq Categorization.last
        end

      end
  end
end
