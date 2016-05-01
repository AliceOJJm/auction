Rails.application.routes.draw do
  resources :lots do
    resources :bids
    get 'participants'
    get '/pictures', to: 'lots#pictures'
  end
  resources :categories
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  
  resources :users, only: [:show, :index, :edit, :update] do
    post '/edit', to: 'users#edit'
    get '/userpage_media', to: 'users#userpage_media'
    resources :subscribtions, only: [:create, :destroy, :edit]
    resources :friends, only: [:index]
    resources :posts do
      post '/toggle_like', to: 'posts#toggle_like'
    end
    resources :pictures
    resources :dialogues
    resources :messages
  end
  resources :comments do
      post '/toggle_like', to: 'comments#toggle_like'
  end
  resources :songs do
      get '/toggle_like', to: 'songs#toggle_like'
  end
  resources :videos do
      post '/toggle_like', to: 'videos#toggle_like'
  end
  resource :tags
  resources :communities do
    get '/join', to: 'communities#join'
    get '/leave', to: 'communities#leave'
    get '/pictures', to: 'communities#pictures'
    resources :posts do
      post '/toggle_like', to: 'posts#toggle_like'
    end
  end
  get 'search', to: 'search#index'
  resources :pictures do
    post '/toggle_like', to: 'pictures#toggle_like'
  end
end
