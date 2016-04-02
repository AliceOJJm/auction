Rails.application.routes.draw do
  root to: 'app#index'
  get "/*path", to: "app#index"
end
