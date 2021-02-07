Rails.application.routes.draw do
  
 
  get "/" => "homes#top" 
  get "home/about" => "homes#index"
  devise_for :users
  root to: "users#show"
  
  resources :users
  resources :books
  
end
