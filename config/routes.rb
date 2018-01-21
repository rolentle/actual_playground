Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :shows do
    resources :ratings, shallow: true
  end

  namespace :api do
    namespace :v1 do
      resources :shows, only: [:index, :show] do
        resources :ratings, only: [:create, :update, :destroy]
      end
    end
  end
  root 'shows#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
