Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users do
        member do
          get :like
        end
      end
      resources :items, only: %i[index show create update destroy]
      resource :item_likes, only: %i[create destroy]
      resource :item_comments, only: %i[create update destroy]
    end
  end
end
