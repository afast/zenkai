Zenkai::Application.routes.draw do
  root to: 'tickets#dashboard'

  devise_for :users
  get 'api/pending_estimates', to: 'Api#pending_estimates'
  resources :tickets do
    collection do
      get :dashboard
      get :list
      get :pending
      get :estimate_pending
      get :current
      get :report
    end
    member do
      put :estimate
      put :re_estimate
    end
  end
  resources :projects
  resources :users do
    member do
      post :approve
    end
  end
  resources :user_ticket_estimates
  resources :sprints do
    collection do
      get :report
    end
  end
end
