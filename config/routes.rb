Rails.application.routes.draw do
  devise_for :users
  resources :shows, only: [:index]
  root 'shows#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
