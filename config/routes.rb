Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
    devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    # customers
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    resources :customers, only: [:index, :edit, :update, :show]

    # homes
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    # camp_items
    resources :camp_items

    # camps
    resources :camps, only: [:index, :show] do
      resources :camp_comments, only: [:new, :create]
    end

  end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    # homes
    get '/' => 'homes#top'

    # cunstomers
    resources :customers, only: [:index, :show, :edit, :update]

    # camp_items
    resources :camp_items, only: [:index, :show]

    # camps
    resources :camps, only: [:index, :show, :edit, :update, :new, :create, :destroy]

    #camp_comments
    resources :camp_comments, only: [:show, :destroy]

    #camp_item_comments
    resources :camp_item_comments, only: [:show, :destroy]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
