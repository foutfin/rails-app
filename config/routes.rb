Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/signup' , to: "user#signup"
  post '/login' , to: "session#login"
  get '/logout' , to: "session#logout"

  get '/posts' , to: "post#allPost"

  get '/status' , to: "status#app"


  get '/ping' , to: "application#ping"
end
