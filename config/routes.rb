Rails.application.routes.draw do
  devise_for :admin, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admin/sessions#new', as: 'new_admin_session'
    post 'admin/sign_in' => 'admin/sessions#create', as: 'admin_session'
    delete 'admin/sign_out' => 'admin/sessions#destroy', as: 'destroy_admin_session'
  end

  scope module: :public do
    root "homes#top"
    get    '/login' => 'sessions#new'
    post   '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
    resources :contacts, only: [:create]
    resources :schedules do
      patch 'status' => 'schedules#status'
      resources :schedule_comments, only: [:create, :destroy]
      resource :schedule_favorites, only: [:create, :destroy]
    end
    resources :employees do
      get 'password' => 'employees#password'
      patch 'update_password' => 'employees#update_password'
      get 'calendars' => 'calendars#index'
    end
    resources :questions, only: [:index]
    resources :replies, only: [:index]
    resources :searches, only: [:index]
    resources :groups do
      resource :group_relationships, only: [:new, :create, :destroy]
    end
  end

  namespace :admin do
    resources :companies, only: [:new, :create, :show, :edit, :update, :index]
  end
end
