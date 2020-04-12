Rails.application.routes.draw do
  devise_for :users
  root to: 'books#top'
  get '/home/about' => 'books#about', as: 'about'
  get '/users' => 'users#users', as: 'users'
  get '/books' => 'books#books', as: 'books'

  resources :books, only: [:show, :create, :update, :edit,:destroy]

  resources :users, only: [:show,:edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
