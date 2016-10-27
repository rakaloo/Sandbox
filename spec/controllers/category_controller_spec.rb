require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "POST #create" do
    let!(:user) { User.create(username: "duke", email:"duke@duke.com", password: "password") }

      context "when valid params are passed, the category is created" do
        it "responds with status code 302" do
          post :create, { params: { category: { name: "dogs" } } }, sign_in(user)
          expect(response).to have_http_status 302
        end

        it "creates a new category in the database" do
          expect{ post :create, { :params => { category: { name: "dogs" } } }, sign_in(user) }.to change{Category.all.count}.by 1
        end

        it "assigns the newly created category as @category" do
          post :create, { :params => { category: { name: "dogs" } } }, sign_in(user)
          expect(assigns(:category)).to eq Category.last
        end

        it "redirects to the created category" do
          post :create, { :params => { category: { name: "dogs" } } } , sign_in(user)
          expect(response).to redirect_to category_path(Category.last)
        end
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
    let!(:category) { Category.create(name: "Clouds") }

    it "responds with status code 200" do
      get :show, { id: category.id }
      expect(response).to have_http_status 200
    end

    it "finds the article based off the id param" do
      get :show, { id: category.id }
      expect((assigns(:category)).id).to eq category.id
    end

    it "renders the :new template" do
      get :show, { id: category.id }
      expect(response).to render_template(:show)
    end
  end

end
