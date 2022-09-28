Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :projects do
    member do
      get :developers_list
      get :QAs_list
      get :assign_dev
      get :assign_qa
      get :remove_dev
      get :remove_qa
    end
  end

  resources :bugs do
    member do
      get :assign
      get :remove
      patch :change_status
    end

    collection do
      get :project_bug_list
      get :work_progress
    end
  end

  resources :dashboard, only: [:index] do
    collection do
      get :developer
    end
  end

  patch "/assign_bug_to_developer", to: "workloads#assign_bug_to_dev"
  patch "/remove_bug_from_developer", to: "workloads#remove_bug_from_dev"

  root 'dashboard#index'
end
