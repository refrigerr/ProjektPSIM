Rails.application.routes.draw do
  resources :usage_histories
  resources :rooms

  resources :cards
  post '/cards/:card_id', to: 'cards#add_room', as: 'add_room'
  get '/rooms/user_index' => 'rooms#user_index'

  devise_for :users
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  resources :users do
      resources :cards
  end
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
