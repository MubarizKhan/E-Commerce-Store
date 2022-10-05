Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :products do
    resources :comments
  end


  resource :carts do
    resources :line_items
    post 'line_items/:id/add', to: 'line_items#add_quantity', as: 'li_aq'
    post 'line_items/:id/red', to: 'line_items#reduce_quantity', as: 'li_rq'
    resources :orders
  end
  resources :orders
  resources :users
  root 'products#index'

  # resources :stars
end
# app/controllers/application_controller.rb
