Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :products do
    resources :comments
  end
  resources :users

  root 'products#index'

  # resources :stars
end
