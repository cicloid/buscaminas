Rails.application.routes.draw do
  resources :games
  root 'dashboard#index'
end
