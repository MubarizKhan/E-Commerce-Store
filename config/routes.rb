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
    get 'line_items/:id/on', to: 'line_items#update_orderNum', as: 'li_on'
    # resources :orders
  end
  put 'line_items/:id/remove', to: 'line_items#remove_lineItem_from_order', as: 'li_ro'
  resources :orders

  post 'orders/:id/checkout', to: 'orders#checkout', as: 'orders_co'


  # do
    # resource :line_items
    #
  # end


  resources :users
  root 'products#index'

  # resources :stars
end
# app/controllers/application_controller.rb
