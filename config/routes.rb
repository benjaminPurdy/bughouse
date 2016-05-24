Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  post '/users/auth/guest', to: 'users#create_guest'                   
  get '/chess', to: 'chess_home#index'
  get '/online_users/refresh', to: 'home#refresh_online_users_list'

  root to: "home#index"
end
