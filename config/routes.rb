Rails.application.routes.draw do
  get 'new_list' => 'lists#new'
  get 'lists' => 'lists#all'
  get 'view_list' => 'lists#show'
  get 'edit_list' => 'lists#edit'
  root 'search#search'
  resources :movies
  resources :lists
  devise_for :users
  get 'search' => 'search#search'
  get 'search_results' => 'search#search_results'
  get 'details/:id' => 'search#details'
  get 'details' => 'search#details'
  get 'save' => 'search#save'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end