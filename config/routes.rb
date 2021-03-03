Rails.application.routes.draw do
  resources :users
  resources :posts
  post 'signup', to: 'users#create'
  post 'authenticate', to: 'users#authenticate' 
  get 'info', to: 'users#info'
  post 'edit', to: 'users#edit'
  post 'create_post', to: 'post#create'
  get 'my_posts', to: 'post#index'
  post 'edit_post', to: 'post#update'
  get 'delete_post/:id', to: 'post#delete'
end 
