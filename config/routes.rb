Rails.application.routes.draw do
  root to: "contacts#index"
  devise_for :users

  resources :contacts, only: [:index, :create, :destroy]
  resources :conversations, only: [:show] do
    resources :messages, only: [:create, :destroy]
  end
end
