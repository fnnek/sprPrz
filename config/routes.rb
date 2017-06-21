Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'
  get 'groups/new'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post 'assign_to_group' => 'users#assign_to_group'
  post 'remove_from_group' => 'users#remove_from_group'
  resources :users do
    member do
      get :following
    end
  end
  root :to => 'home#index'

  resources :groups

  resources :messages, only: [:create,:destroy]
  resources :relationships, only: [:create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
