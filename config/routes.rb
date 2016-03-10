Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do

    scope module: :v1 do

      resources :users
      resources :users, param: :username
      resources :subboards, param: :name
      resources :posts
      
      # resources :comments
      # resources :moderators
      # List all resources here

    end

  end

end
