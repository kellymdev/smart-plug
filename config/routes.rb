Rails.application.routes.draw do
  root to: 'plugs#index'

  resources :plugs do
    resources :data_files, only: :create
  end
end
