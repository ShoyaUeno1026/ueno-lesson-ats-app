Rails.application.routes.draw do
  get 'registrations/update_resource'
  get 'dashboards/show'
  get 'announcements/index'

  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :accounts
      resources :account_users
      resources :departments
      resources :users
      root to: "users#index"
    end
  end

  get "/terms"   => "static_pages#terms"
  get "/privacy" => "static_pages#privacy"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  devise_scope :user do
    get '/users/sign_out' => "devise/sessions#destroy"
  end
  
  namespace :account do
    resource :passwords
  end
  
  get "/announcements" => "announcements#index"
  get "/notifications" => "notifications#index"

  resources :accounts do
    member do
      patch :switch
    end

    scope module: :accounts do
      resources :departments
      resources :candidates
      resources :jobs
      resources :job_pipelines do
        resources :job_pipeline_stages, path: :stages, module: :job_pipelines
      end
      resources :matches
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  authenticated :user do
    root "dashboards#show", as: :user_root
  end

  root "static_pages#home"
end
