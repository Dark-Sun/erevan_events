
Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  
  root to: "admin/venues#index"



  namespace :api do
    namespace :v1 do
      resources :venues
      resources :venue_categories
      resources :users
      resources :user_categories
      resources :favorite_events
      resources :favorite_venues
    end
  end



end
