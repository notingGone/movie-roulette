Rails.application.routes.draw do
  root 'movies#details'
  resources :movies
  devise_for :views
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
