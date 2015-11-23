require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  
  # namespace :admin do
    authenticate :admin_user do
      mount Sidekiq::Web => '/sidekiq'
    end
  # end  

  root to: "admin/venues#index"

  namespace :api do
    namespace :v1 do
      resources :venues
      resources :venue_categories
      resources :users 
      resources :user_categories
      resources :favorite_events
      resources :favorite_venues

      put 'user_log_out' => "users#log_out"
    end
  end



end
