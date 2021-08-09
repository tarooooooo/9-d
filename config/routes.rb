Rails.application.routes.draw do

  get 'rooms/index'
  get 'rooms/show'
  devise_for :users

  resources :users, only: [:show,:index,:edit,:update,:create,:new] do
    get "search" , to: "users#search"
    resource :relationships, only: [:create,:destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books, only:[:create,:index,:show,:edit,:update,:destroy] do
    resources :book_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
  end

  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :index, :show]
  post 'rooms/:id' => 'rooms#show'

  get 'search' => "searches#search"
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
end
