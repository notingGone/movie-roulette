Rails.application.routes.draw do
  root 'lists#roulette'
  post 'remove_from_queue' => 'lists#remove_from_queue'
  post 'remove_from_list' => 'lists#remove_from_list'
  get 'new_list' => 'lists#new'
  get 'lists' => 'lists#all'
  get 'view_list' => 'lists#show'
  get 'edit_list' => 'lists#edit'
  get 'search' => 'movies#search'
  get 'search_results' => 'movies#search_results'
  get 'details/:id' => 'movies#details'
  get 'details' => 'movies#details'
  get 'save' => 'lists#save'
  get 'test' => 'movies#test'
  get 'roulette' => 'lists#roulette'
  get 'queue' => 'lists#queue'
  get 'filter' => 'lists#filter'
  get 'spin' => 'lists#spin'
  post 'add' => 'lists#add'
  post 'queue' => 'lists#add_to_queue'
  devise_for :users
  resources :movies, except: :new
  resources :lists

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
