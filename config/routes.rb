Rails.application.routes.draw do
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout  


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :questions
  resources :users, only: %i[new create]
  root :to => 'tops#index'

  mount ActionCable.server => '/cable'
  get 'rooms/show/:id' => 'rooms#show', :as => :chat
end
