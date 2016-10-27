Rails.application.routes.draw do
  devise_for :users

  resources :users_admin, :controller => 'users', only: [:index, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :category, except: :new
  root to: "articles#index"

  resources :articles, except: [:edit, :update] do
  	resources :versions, except: [:edit, :update]
  end
end
