Rails.application.routes.draw do
  resources :usage_histories
  resources :rooms

  resources :cards
  post 'users/:user_id/cards/:card_id', to: 'cards#add_room'
  post '/cards/:card_id', to: 'cards#add_room', as: 'add_room'
  get '/rooms/user_index' => 'rooms#user_index'

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  resources :users do
      resources :cards, expect: [:update]
  end
  patch 'users/:user_id/cards/:id', to: 'cards#update', as: 'update_user_card'

  resources :cards do
    member do
      post 'unassign_room/:room_id', to: 'cards#unassign_room', as: 'unassign_room'
    end
  end

  root 'pages#index'
  get '/pages/show', to: 'pages#show', as: 'pages_show'
  patch '/pages/show', to: 'cards#update', as: 'pages_update'
end
