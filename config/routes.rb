Rails.application.routes.draw do
  post "auth" => "authentication#create", as: :auth
end
