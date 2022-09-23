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

  resources :bugs
  root 'dashboard#index'
end
