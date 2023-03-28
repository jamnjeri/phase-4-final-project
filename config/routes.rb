Rails.application.routes.draw do
  
  # user
  get '/user/login/check', to: 'users#check_login_status'
  post '/users', to: 'users#register'
  post '/users/login', to: 'users#login'
  delete '/users/logout', to: 'users#logout'
  

end
