Rails.application.routes.draw do
  devise_for :admins

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get "about" => "public/homes#about", as: "about"

  resources :items, only: [:index, :show]
  resources :registrations, only: [:new, :create]
  resource :customers, only: [:edit, :update]
  get 'customers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw', as: 'withdraw'
  get 'customers/my_page' => 'public/customers#show', as: 'my_page'

  resources :cart_items, only: [:index, :update, :create, :destroy]
  delete 'cart_items/all_destroy' => 'public/cart_items#all_destroy', as: 'all_destroy'

  resources :orders , only: [:new, :create, :index, :show]
  post 'orders/confirm' => 'public/orders#confirm', as: 'confirm'
  get 'orders/complete' => 'public/orders#complete', as: 'complete'

  resources :addresses, only: [:index, :edit, :create, :update, :destroy]


  namespace :admin do
    root to: "homes#top"


    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :accept_orders, only: [:show, :update]
    resources :accept_order_details, only: [:update]


  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
