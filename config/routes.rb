Rails.application.routes.draw do
  get 'registrations/update_resource'
  get 'dashboards/show'
  get 'announcements/index'
  # namespace :admin do
  #   resources :users
    
  #   root to: "users#index"
  # end

  get "/terms"   => "static_pages#terms"
  get "/privacy" => "static_pages#privacy"
  devise_for :users, controllers: {
        registrations: 'users/registrations',
        sessions: 'users/sessions'
      }

  devise_scope :user do
    get '/users/sign_out' => "devise/sessions#destroy"
  end

  get "/announcements" => "announcements#index"
  get "/notifications" => "notifications#index"
  
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
