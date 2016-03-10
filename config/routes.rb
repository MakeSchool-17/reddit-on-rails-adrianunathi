Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do

    scope module: :v1 do

      resources :users

      # resources :subboards
      # resources :posts
      # resources :comments
      # resources :moderators
      # List all resources here

    end

  end

end
