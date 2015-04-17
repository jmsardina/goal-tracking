Rails.application.routes.draw do
  resources :feeds
  resources :search
  devise_for :users, controllers: {:omniauth_callbacks => "users/omniauth_callbacks", sessions: 'users/sessions', registrations: "users/registrations"  }

  # devise_scope :user do
  #   get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  root to: 'goals#index'
  resources :invitations

  get 'welcome/index' => 'welcome#index'

  resources :goals do
    # resources :comments
    resources :activities
  end

  resources :boards do
    resources :comments
    resources :cheers
  end

  resources :comments do 
    resources :comments
    resources :cheers
  end
  
  get 'users/search' => 'users#search'

  resources :groups do
    resources :boards
    resources :cheers
  end
  resources :comments
  
  post 'groups/:id' => 'comments#create'

  resources :user_groups
end
