Rails.application.routes.draw do
  root "dashboard#home"

  resources :proprietarios do
    resources :veiculos
  end

  get "consulta", to: "consultas#index"

  get "/consulta", to: "consultas#index", as: :consulta_veiculos


end
