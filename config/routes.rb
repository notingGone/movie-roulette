Rails.application.routes.draw do
  get 'lists/new'
  get 'lists/all'
  get 'lists/view'
  get 'lists/edit'
  root 'search#search'
  resources :movies
  devise_for :views
  devise_for :users
  get 'search' => 'search#search'
  get 'search_results' => 'search#search_results'
  get 'details' => 'search#details'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
