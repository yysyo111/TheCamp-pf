Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  scope module: :public do
    # customers
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    resource :customers, only: [:edit, :update, :index, :show]

    # homes
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    # camp_items
    resources :camp_items

    # camps
    resources :camps

  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  
  
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    # homes
    get '/' => 'homes#top'

    # cunstomers
    resources :customers

    # camp_items
    resources :camp_items

    # camps
    resources :camps
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
