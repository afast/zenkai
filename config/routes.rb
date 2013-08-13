Iepc::Application.routes.draw do
  root to: 'tickets#dashboard'

  devise_for :users

  resources :tickets do
    collection do
      get :dashboard
      get :list
      get :report
    end
    member do
      put :estimate
      put :re_estimate
    end
  end
  resources :projects
  resources :users
  resources :user_ticket_estimates
end
