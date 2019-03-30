Rails.application.routes.draw do
  root 'search#search'
  resources :movies
  devise_for :views
  devise_for :users
  get 'search' => 'search#search'
  get 'search_results' => 'search#search_results'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
