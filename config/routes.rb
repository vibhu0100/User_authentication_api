Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'signup', to: 'users#create'
<<<<<<< Updated upstream
  post 'authenticate', to: 'users#authenticate' 
end
=======
  post 'login', to: 'users#login'
  post 'send_otp', to: 'users#send_otp'
  post 'verify_otp', to: 'users#verify'
  get 'info', to: 'users#info'
  post 'edit', to: 'users#edit'
  post 'create_post', to: 'post#create'
  get 'my_posts', to: 'post#index'
  post 'edit_post', to: 'post#update'
  get 'delete_post/:id', to: 'post#delete'
  post 'otp', to: 'otp#create'
end 
>>>>>>> Stashed changes
