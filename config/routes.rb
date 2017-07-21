Rails.application.routes.draw do
  root to: 'plugs#index'

  resources :plugs

  post '/plugs/:id/upload', to: 'data_files#upload'

  get '/plugs/:plug_id/consumption_data', to: 'graphs#consumption_data'
  get '/plugs/:plug_id/temperature_data', to: 'graphs#temperature_data'
end
