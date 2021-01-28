Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/login', to: 'session#login'
  post '/signup', to: 'session#signup'
  delete '/logout', to: 'session#logout'
  get '/dashboard', to: 'session#dashboard'

  resources :games

end
