Rails.application.routes.draw do
  devise_for :users

  resources :products do
    resources :comments
  end


  resource :carts do
    resources :line_items
    post 'line_items/:id/add', to: 'line_items#add_quantity', as: 'li_aq'
    post 'line_items/:id/red', to: 'line_items#reduce_quantity', as: 'li_rq'
    get 'line_items/:id/on', to: 'line_items#update_orderNum', as: 'li_on'

  end
  put 'line_items/:id/remove', to: 'line_items#remove_lineItem_from_order', as: 'li_ro'
  resources :orders

  post 'orders/:id/checkout', to: 'orders#checkout', as: 'orders_co'
  get 'orders/order', to: 'orders#order', as: 'place_order'


  resources :users
  get "users/:id/choose_role", to: "users#choose_role", as: "choose_role"
  post 'users/:id/buyer', to:"users#buyer", as:"buyer"
  post 'users/:id/seller', to:"users#seller", as:"seller"

  root 'products#index'

end
