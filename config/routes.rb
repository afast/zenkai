Iepc::Application.routes.draw do
  root to: 'tickets#dashboard'

  devise_for :users

  resources :tickets do
    collection do
      get :dashboard
    end
  end
  resources :projects
  resources :users
end
