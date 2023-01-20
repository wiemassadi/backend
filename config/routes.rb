Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  resources :motifs, only: %i[create index show update destroy]
  resources :demandes, only: %i[create index show update destroy]
  delete :logout,to: "sessions#logout"
  get :logged_in, to:"sessions#logout"
  get :statistique_employer, to: "demandes#statistique_employer"
  get :statistique_admin, to: "demandes#statistique_admin"
  root to: "static#home"
  resources :registrations do
    member do
      get :confirm_email
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
