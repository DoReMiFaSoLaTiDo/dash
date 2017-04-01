Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, path: '/' do
    resources :doctors, constraints: { format: 'json' }
    resources :reviews, constraints: { format: 'json' }
  end
  
end
