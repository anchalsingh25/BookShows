Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index] do
        collection do
          post :login, :register
          get :logout
        end
      end
      resources :events
      resources :locations
      resources :prices
      resources :location_price_event_mappings
      resources :carts
      resources :booking_items
      resources :bookings
      resources :payments
    end
  end
end
