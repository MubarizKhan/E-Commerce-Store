Rails.application.routes.draw do

  root 'products#index'

  devise_for :users


  resource :carts

  resources :line_items do
    member do
      post :add, to: 'line_items#add_quantity', as: 'add_quantity'
      post 'red', to: 'line_items#reduce_quantity', as: 'reduce_quantity'
    end

    collection do
      post 'checkout', to: 'line_items#checkout', as: 'checkout'
    end

    # put :remove, to: 'line_items#remove_lineItem_from_order', as: 'li_ro'
  end

  resources :orders do
    member do
      post :place#, to: 'orders#order', as: 'place_order'
      get :active_order
    end
  end

  resources :products do
    resources :comments
  end

  resources :users do
    member do
      get :choose_role
      post :buyer
      post :seller
    end
  end


end














  # resources :orders do
    # member do
      # post :order, to: 'orders#order', as: 'place_order'
      # get :active_order, to: 'orders#active_order', as: 'active_order'
    # end
  # end
#
#
#
  # resources :users do
    # member do
      # get :choose_role, to:'users#choose_role', as: 'choose_role'
      # post :buyer, to:'users#buyer', as:'buyer'
      # post :seller, to:'users#seller', as:'seller'
    # end

# resource :carts do
  #   resources :line_items
  #   post 'line_items/:id/add', to: 'line_items#add_quantity', as: 'li_aq'
  #   post 'line_items/:id/red', to: 'line_items#reduce_quantity', as: 'li_rq'
  #   get 'line_items/:id/on', to: 'line_items#update_orderNum', as: 'li_on'
  #   post 'line_items/checkout', to: 'line_items#checkout', as: 'checkout'
  # end
  # put 'line_items/:id/remove', to: 'line_items#remove_lineItem_from_order', as: 'li_ro'
