Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  scope module: :users do
    resources :posts, only: %i[new create edit update destroy]
    resources :relationships, only: %i[create destroy]
  end
  resources :posts, only: %i[index show]
end
