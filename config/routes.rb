Rails.application.routes.draw do
  # namespace :admin do
  #   resources :users
    
  #   root to: "users#index"
  # end

  get "/terms"   => "static_pages#terms"
  get "/privacy" => "static_pages#privacy"
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  authenticated :user do
    root "dashboads#show", as: :user_root
  end

  root "static_pages#home"
end
