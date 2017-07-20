Rails.application.routes.draw do
  root to: 'plugs#index'

  resources :plugs
end
