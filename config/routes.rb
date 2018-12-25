Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users

  resources :users do
    resources :photos, except: [:edit, :update, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create]
    end
  end

  root 'welcome#index'
end
