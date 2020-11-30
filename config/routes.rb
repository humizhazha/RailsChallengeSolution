Rails.application.routes.draw do
  root 'page#home'
  post 'insertDatabase', to: 'page#importToDatabase'
  resources :people


end
