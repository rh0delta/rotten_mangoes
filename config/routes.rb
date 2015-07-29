RottenMangoes::Application.routes.draw do

  get 'admin/index'

  get 'admin/show'

  get 'admin/new'

  get 'admin/create'

  get 'admin/edit'

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end

  root to: 'movies#index'

end
