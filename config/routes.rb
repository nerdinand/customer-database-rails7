Rails.application.routes.draw do
  root to: 'customers#index'

  resources :customers do
    resources :orders, only: %i[show] do
      patch 'paid'
      patch 'delivered'
    end
  end

  resource :cart, only: %i[show update] do
    get 'check_out', to: 'carts#check_out'
    post 'check_out', to: 'carts#confirm_check_out'
    delete 'line_item'
  end

  resources :orders, only: %i[index]

  resources :products
end
