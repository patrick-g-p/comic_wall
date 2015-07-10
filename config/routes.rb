Rails.application.routes.draw do
  root 'comics#index'

  get '/register', to: 'users#new'
  resources :users, except: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :comics, except: [:destroy] do
    collection do
      get '/search', to: 'comics#search'
    end

    resources :discussions, except: [:index, :edit, :update] do
      resources :replies, only: [:create]
    end
  end
end
