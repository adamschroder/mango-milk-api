MangoMilk::Application.routes.draw do
  resources :users
  post 'users/login'
  resources :shows
  resources :episodes
  resources :watched_episodes
end
