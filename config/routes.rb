Rails.application.routes.draw do
  
  root "static_pages#index"
  resources :users do
    member do
      get :following, :followers
    end
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :microposts,          only: [:create, :destroy, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
