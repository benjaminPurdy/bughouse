Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  post '/users/auth/guest', to: 'users#create_guest'                   
  get '/chess', to: 'chess_home#index'

  root to: "home#index"
end
