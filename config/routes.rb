Rails.application.routes.draw do

  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end

  namespace :api, defaults: { format: :json } do

    scope module: :v1 do
      devise_for :users, class_name: "User",
                         controllers: { sessions: 'devise/sessions' }
      resources :users, param: :username
      resources :subboards, param: :name
      resources :posts
      resources :comments
      resources :subscriptions, param: :username
    end

  end

end
