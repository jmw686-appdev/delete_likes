Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "auth#index"

  get '/auth/tumblr/callback' => 'auth#show'
end
