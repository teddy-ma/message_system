Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :contacts, only: [:create, :destroy]
  resources :conversations, only: [:show] do
    resources :messages, only: [:create, :destroy]
  end
end
