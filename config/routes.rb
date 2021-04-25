Rails.application.routes.draw do
  root to: 'tops#index'
  resource :users, only: :show do
    collection do
      patch :update_eat_day
    end
  end
  devise_for :users
end
