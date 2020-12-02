Rails.application.routes.draw do
  devise_for :users
  root to: 'notes#index'
  resources :notes do
    collection do
      get 'publish'
      get 'search_title'
      get 'search_text'
      get 'search_title_user'
      get 'search_text_user'
      get 'search_tag_user'
    end
  end
  resources :users, only: [:show, :edit, :update]
  resources :tags, only: :show do
    collection do
      get 'search'
    end
  end
end
