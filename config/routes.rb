Rails.application.routes.draw do
  root to: 'plugs#index'

  resources :plugs

  post '/plugs/:id/upload', to: 'data_files#upload'
end
