Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users
  root 'home#index'

  get '/transactions', to: 'trades#index'
  get '/transactions/new', to: 'trades#new'
end
