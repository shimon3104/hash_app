Rails.application.routes.draw do
  devise_for :users
  root to: "notes#index"
  resources :notes
  resources :users, only: [:show, :edit, :update]
end
