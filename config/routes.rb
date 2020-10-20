Rails.application.routes.draw do
  root 'page#home'
  post 'insertDatabase', to: 'page#importToDatabase'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
