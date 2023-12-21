require 'sidekiq/web'
require 'sidekiq-scheduler/web'

authenticate :user, lambda { |u| u.id == 1 } do
  mount Sidekiq::Web => '/sidekiq'
end

Rails.application.routes.draw do
  root 'static_pages#top'
  get 'static_pages/terms'
  get 'static_pages/privacy'
  
  get 'matching_times/index'
  mount Sidekiq::Web, at: '/sidekiq'
  
  get 'auth/:provider/callback', to: 'user_sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'log_out', to: 'user_sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :questions do
    member do
      get :show_reservations
      get :choose_schedule
      post :create_deadline
    end
    resources :matching_times, only: %i[index]

    resources :reservations do
      collection do
        patch :bulk_update
        get :index_vote
      end
    
  
      resources :votes
    end
  end
  resources :users, only: %i[new create]

  mount ActionCable.server => '/cable'
  get 'rooms/show/:id' => 'rooms#show', :as => :chat
end
