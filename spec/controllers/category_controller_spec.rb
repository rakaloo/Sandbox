require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }
    let!(:admin) { User.create(username: "Ellie", email:"ellie@ellie.com", password: "password", role: "Admin") }
    let!(:category) { Category.create(name: "Animals") }
    let!(:second_category) { Category.create(name: "Clouds") }

      context "when admin is the user trying to destroy a post" do

        it "responds with status code 302" do
          delete :destroy, { id: category.id }, sign_in(admin)
          expect(response).to have_http_status 302
        end

        it "destroys an article" do
          expect{ delete :destroy, { id: category.id }, sign_in(admin) } .to change{Category.all.count}.by -1
        end

        it "destroys the specific category" do
          delete :destroy, { id: category.id }, sign_in(admin)
          expect(Category.pluck(:id)).not_to include(category.id)
        end
      end

      context "when user is trying to destroy a post" do
       it "responds with 422 public rejection file" do
        delete :destroy, { id: category.id }, sign_in(user)
        expect(response).to render_template(:file => "#{Rails.root}/public/422.html")
        end
      end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
