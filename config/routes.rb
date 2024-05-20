Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show]
  root 'posts#index'
  scope module: :users do
    resources :posts, only: %i[new create edit update destroy]
    resources :relationships, only: %i[create destroy]
    resource :following_posts, only: %i[show]
    resource :profile, only: %i[show edit update]
  end
  resources :posts, only: %i[index show]
end
