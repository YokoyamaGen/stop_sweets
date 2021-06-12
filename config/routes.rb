Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  root to: 'tops#index'
  
  resources :users, only: [:show] do
    patch :update_eat_day, on: :member
  end 

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :posts do
    resource :likes, only: [:create, :destroy]
    resource :comments, only: [:new, :create]
    resources :comments, only: [:edit, :update, :destroy]
  end
end
