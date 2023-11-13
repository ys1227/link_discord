Rails.application.routes.draw do
  root :to => 'tops#index'
  
  get 'auth/:provider/callback', to: 'user_sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'log_out', to: 'user_sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :questions
  resources :users, only: %i[new create]
  resources :reservations

  mount ActionCable.server => '/cable'
  get 'rooms/show/:id' => 'rooms#show', :as => :chat
end
