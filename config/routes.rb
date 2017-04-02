Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, path: '/' do
    resources :doctors, constraints: { format: 'json' } do
      resources :reviews, only: [:create, :update, :delete, :show]
    end
    resources :reviews, constraints: { format: 'json' }, only: [:index]
  end

end
