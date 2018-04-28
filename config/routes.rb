Rails.application.routes.draw do

  post "auth" => "authentication#create", as: :auth
  resources :trips , only: [:index, :create]
  get "trips_summary" => "trips#trips_summary", as: :trips_summary

end
