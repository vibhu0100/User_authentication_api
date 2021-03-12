Rails.application.routes.draw do
  resources :users
  resources :posts
  post 'signup', to: 'users#create'
  post 'login', to: 'users#login'
  get 'logout', to: 'users#logout'
  post 'send_otp_for_password', to: 'users#send_otp'
  post 'verify_for_password', to: 'users#verify_for_password'
  post 'reset_password', to: 'users#reset_password'
  post 'send_otp', to: 'users#send_otp'
  post 'verify_otp', to: 'users#verify'
  get 'info', to: 'users#info'
  post 'edit', to: 'users#edit'
  post 'create_post', to: 'post#create'
  get 'my_posts', to: 'post#index'
  post 'post/:id/edit', to: 'post#update'
  get 'post/:id/delete', to: 'post#delete'
  get 'post/:id/images', to: 'post#image'
  post 'post/:id/add_images', to: 'post#add_image'
  get 'post/:id/delete_image/:blob_id', to: 'post#delete_image'
  post 'upload_csv', to: 'csv#read_csv'
end 
