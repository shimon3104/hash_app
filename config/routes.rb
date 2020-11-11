Rails.application.routes.draw do
  devise_for :users
  root to: "notes#index"
  resources :notes, only: [:index]
  resources :users, only: [:edit, :update]
end
