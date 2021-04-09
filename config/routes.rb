Rails.application.routes.draw do
  namespace :public do
    get 'replies/index'
  end
  namespace :public do
    get 'sessions/new'
  end
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
      resources :schedulecomments, only: [:create, :destroy]
      resource :schedulefavorites, only: [:create, :destroy]
    end
    resources :employees do
      get 'calendars' => 'calendars#index'
    end
    resources :questions, only: [:index]
    resources :replies, only: [:index]
    resources :searches, only: [:index]
    resources :groups, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :grouprelationships, only: [:new, :create]
    end
  end

  namespace :admin do
    resources :companies, only: [:new, :create, :show, :edit, :update, :index]
  end
end
