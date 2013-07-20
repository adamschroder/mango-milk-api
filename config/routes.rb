MangoMilk::Application.routes.draw do
  resources :users
  resources :shows
  resources :episodes
  resources :watched_episodes
end
