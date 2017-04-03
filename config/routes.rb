Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, path: '/' do
    resources :doctors, constraints: { format: 'json' } do
      resources :reviews, only: [:index, :create, :update, :destroy, :show]
    end
  end

end
