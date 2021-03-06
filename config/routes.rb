Rails.application.routes.draw do
  
  root "static_pages#index"


  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers, :gallery
    end
  end

  resources :posts,          only: [:create, :destroy, :update]
  resources :relationships,  only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
