Rails.application.routes.draw do
  devise_for :admin, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admin/sessions#new', as: 'new_admin_session'
    post 'admin/sign_in' => 'admin/sessions#create', as: 'admin_session'
    delete 'admin/sign_out' => 'admin/sessions#destroy', as: 'destroy_admin_session'
  end

  devise_for :employee, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root "homes#top"
    resources :contacts, only: [:create]
    resources :schedules, only: [:index, :show, :new, :create] do
      patch 'status' => 'schedules#status'
      resources :comments, only: [:create, :destroy]
      resources :schedulefavorites, only: [:create, :destroy]
    end
    resources :employees, only: [:show, :edit, :update]
    resources :questions, only: [:index]
    resources :replies, only: [:index]
    resources :searches, only: [:index]
    resources :groups, only: [:new, :create, :show, :edit, :update, :destroy]
  end

  namespace :admin do
    resources :companies, only: [:new, :create, :show, :edit, :update, :index]
  end
end
