Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home'
  devise_for :users
  resources :demand_activations, only: [:new, :create, :edit]
  resources :demands, only: [:new, :create]
  resources :costs do
    get 'survey', on: :collection
  end
end
