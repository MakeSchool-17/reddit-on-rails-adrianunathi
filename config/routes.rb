Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do

    scope module: :v1 do
      devise_for :users
      resources :users
      resources :users, param: :username
      resources :subboards, param: :name
      resources :posts
      resources :comments
      resources :subscriptions, param: :username

    end

  end

end
