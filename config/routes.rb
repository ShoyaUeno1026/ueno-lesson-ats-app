Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :accounts
      resources :account_users
      resources :announcements
      resources :departments
      resources :users do
        resource :impersonate, module: :user
      end
      
      root to: "users#index"
    end
  end

  get 'registrations/update_resource'
  get 'dashboards/show'
  
  get "/terms"   => "static_pages#terms"
  get "/privacy" => "static_pages#privacy"
  get "/announcements" => "announcements#index"
  get "/notifications" => "notifications#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  
  devise_scope :user do
    get '/users/sign_out' => "devise/sessions#destroy"
  end
  
  namespace :account do
    resource :passwords
  end

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
      resources :match_histories
      resources :account_users
      resources :account_invitations, path: :invitations do
        member do
          post :resend
        end
      end
      resources :tasks
    end
  end

  resources :account_invitations

  scope module: :entry do
    resources :accounts
    resources :departments
    resources :candidates
    resources :jobs
    resources :matches
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
