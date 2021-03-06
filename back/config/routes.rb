Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users do
        member do
          get :like
          get :topic
          get :show_items
          get :show_followings
          get :show_followers
          patch :update_avatar
        end
      end
      namespace :items do
        get :top
        get :ranking
        get :timeline
      end
      resources :items, only: %i[index show create update destroy] do
        get :search, on: :collection
        get :search_ranking, on: :collection
      end
      resource :item_likes, only: %i[create destroy]
      resources :item_comments, only: %i[create destroy]
      namespace :tags do
        get :top
      end
      resources :tags, only: %i[index show] do
        get :search, on: :collection
        member do
          get :ranking
        end
      end
      resources :relationships, only: [:create, :destroy]
      namespace :topics do
        get :ranking
      end
      resources :topics, only: %i[index show create destroy update] do
        get :search, on: :collection
        member do
          get :fetch
        end
      end
      get 'health_check', to: 'health_check#index'
    end
  end
end
