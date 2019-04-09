Rails.application.routes.draw do
  post 'remove_movie' => 'lists#remove_movie'
  get 'new_list' => 'lists#new'
  get 'lists' => 'lists#all'
  get 'view_list' => 'lists#show'
  get 'edit_list' => 'lists#edit'
  resources :movies
  resources :lists
  devise_for :users
  get 'search' => 'movies#search'
  get 'search_results' => 'movies#search_results'
  get 'details/:id' => 'movies#details'
  get 'details' => 'movies#details'
  get 'save' => 'lists#save'
  get 'add' => 'lists#add'
  root 'movies#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
