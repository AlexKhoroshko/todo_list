Rails.application.routes.draw do
  devise_for :users

  resources :tasks, except: [:show] do
    member do
      get :logs
    end
  end

  root 'tasks#index'
end
