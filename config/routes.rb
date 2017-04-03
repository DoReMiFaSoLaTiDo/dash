Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, path: '/' do
    resources :doctors, only: [:index, :create, :update, :destroy, :show] do
      resources :reviews, only: [:index, :create, :update, :destroy, :show]
    end
  end

end
