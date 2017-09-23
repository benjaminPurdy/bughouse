Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :comments, only: [:new, :create, :index]

  get 'chess_game/new'

  get 'chess_game/create'

  get 'chess_game/update'

  get 'chess_game/edit'

  get 'chess_game/destroy'

  get 'chess_game/show'

  get 'chess_game/index/:id', to: 'chess_game#index'

  post 'chess_game/make_move', to: 'chess_game#make_move'

  post 'message/global', to: 'message#create_global_message'
  post 'pusher/auth', to: 'pusher#auth'
  post '/users/auth/guest', to: 'users#create_guest'                   
  post '/chess/create_game', to: 'chess_home#create_game'
  delete '/chess/cancel_search', to: 'chess_home#cancel_search'
  get '/chess', to: 'chess_home#index'
  get '/online_users/refresh', to: 'home#refresh_online_users_list'

  root to: "home#index"
end
