Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "posts#index"

  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "/up", to: ->(_) { [ 200, {}, [ "OK" ] ] }
end
