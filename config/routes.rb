Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do

    scope module: :v1 do

      resources :users, param: :username
      resources :subboards, param: :name
      #Moderator calls
      get 'subboards/:name/moderators' => 'moderators#index'
      post 'subboards/:name/moderators' => 'moderators#create'
      delete 'subboards/:name/moderators/:username' => 'moderators#destroy'
      #Subscriber calls
      get 'subboards/:name/subscribers' => 'subscriptions#index'
      post 'subboards/:name/subscribers' => 'subscriptions#create'
      delete 'subboards/:name/subscribers/:username' => 'subscriptions#destroy'
      #Post calls
      get 'subboards/:name/posts' => 'posts#index'
      post 'subboards/:name/posts' => 'posts#create'
      delete 'subboards/:name/posts/:id' => 'posts#destroy'
      #comment calls
      get 'subboards/:name/:parent_type/:parent_id/comments' => 'comments#index'
      post 'subboards/:name/:parent_type/:parent_id/comments' => 'comments#create'
      delete 'subboards/:name/:parent_type/:parent_id/comments/:id' => 'comments#destroy'
      resources :posts
      resources :comments
      # resources :posts, only: [:show, :destroy]
      # resources :comments, only: [:destroy]
      resources :subscriptions, param: :username
      resources :moderators, param: :username

    end

  end

end
