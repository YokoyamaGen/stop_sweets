Rails.application.routes.draw do
  devise_for :users
  root to: 'tops#index'
  resources :users do
    patch :update_eat_day, on: :member
  end 
end
