Benfeitor::Application.routes.draw do
  
  root to: 'posts#index'

  delete '/signout', to: 'sessions#destroy'
  post '/signin', to: 'sessions#create'
  get '/signin', to: 'sessions#new'
  get '/signup', to: 'users#new'
  get '/users/:username', to: 'users#show', as: 'user_posts'

  resources :posts
  resources :users
  resources :sessions

end
