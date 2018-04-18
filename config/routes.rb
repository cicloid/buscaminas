Rails.application.routes.draw do
  resources :games, only: [:create, :show] do
    resources :flags, only: [:create]
    resources :reveals, only: [:create]
  end
  root 'dashboard#index'
end
