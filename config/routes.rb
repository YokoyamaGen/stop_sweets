Rails.application.routes.draw do
  root to: 'tops#index'
  devise_for :users
  resource :users, only: :show
end
