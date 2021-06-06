Rails.application.routes.draw do
  root to: 'home#top'
  get 'home/about'
  devise_for :users
  resources :users, only: %i[index show edit update]
  resources :books, except: :new
end
