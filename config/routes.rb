Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :articles
      resources :authors

      resources :transactions do
        collection do
          post 'debit'
          post 'credit'
          post 'transfer'
        end
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "api/v1/articles#index"

  # session authenticate
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Api-key authenticate
  resources :api_keys, path: 'api-keys', only: %i[index create destroy]
end
