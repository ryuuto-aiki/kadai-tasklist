Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  

end
