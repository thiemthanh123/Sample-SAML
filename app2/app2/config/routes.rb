# config/routes.rb
Rails.application.routes.draw do
  get 'callback', to: 'sessions#callback'
  root to: 'sessions#callback'
end
