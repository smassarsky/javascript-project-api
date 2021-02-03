Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/login', to: 'session#login'
  post '/signup', to: 'session#signup'
  delete '/logout', to: 'session#logout'
  get '/dashboard', to: 'session#dashboard'

  resources :games, only: [:index, :show]

  resources :user_games, only: [:index, :show, :create, :destroy] do 
    resources :items, only: [:index]
  end

  resources :loadouts, only: [:show, :create, :update, :destroy] do 
    resources :loadout_items, only: [:index, :create]
  end

  resources :tasks, only: [:show, :create, :update, :destroy]

  resources :items, only: [:create, :update, :destroy]

  resources :loadout_items, only: [:update, :destroy]

end
