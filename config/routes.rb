Rails.application.routes.draw do
  devise_for :users
  root to: "notes#index"
  resources :notes do
    collection do
      get 'publish'
      get 'search_text'
      get 'search_title'
    end
  end
  resources :users, only: [:show, :edit, :update]
end
