Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  get 'customers/edit' => 'public/customers#edit', as: 'edit_customer'
  patch 'customers' => 'public/customers#update', as: 'update_customer'

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get "about" => "public/homes#about", as: "about"

  scope module: :public do
  resources :cart_items, only: [:index, :update, :create, :destroy] do
    collection do
      delete 'all_destroy' => 'cart_items#all_destroy', as: 'all_destroy'
    end
  end

  resources :items, only: [:index, :show]
  resources :orders , only: [:new, :create, :index, :show] do
    collection do
      get 'complete' => 'orders#complete', as: 'complete'
      post 'confirm' => 'orders#confirm', as: 'confirm'
    end
  end
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end


  get 'customers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw', as: 'withdraw'
  get 'customers/my_page' => 'public/customers#show', as: 'my_page'



  post 'orders/confirm' => 'public/orders#confirm', as: 'confirm'







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
