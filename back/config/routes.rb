Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :items
      resource :item_likes, only: %i[create destroy]
    end
  end
end
