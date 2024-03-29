require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  root 'static_pages#top'
  get 'static_pages/terms'
  get 'static_pages/privacy'

  get 'matching_times/index'

  get 'auth/:provider/callback', to: 'user_sessions#create'
  get 'auth/failure', to: redirect('/')
  post '/guest_login', to: 'user_sessions#guest_login'
  delete 'log_out', to: 'user_sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :questions do
    member do
      get :show_reservations
      get :choose_schedule
      get :draft
      get :published
      get :voted
      post :create_deadline
    end
    resources :matching_times, only: %i[index]
    resources :messages, only: %i[destroy]

    resources :reservations do
      collection do
        patch :bulk_update
        get :index_vote
      end

      resources :votes
    end
  end
  resources :users, only: %i[new create show]

  mount ActionCable.server => '/cable'
  get 'rooms/show/:id' => 'rooms#show', :as => :chat
end
