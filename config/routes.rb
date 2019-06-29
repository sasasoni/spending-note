Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home'
  devise_for :users
  resources :demand_activations, only: [:new, :create, :edit]
  resources :demands, only: [:index, :show, :new, :create, :edit, :update] do
    get 'approve', on: :member
    get 'receive', on: :member
  end
  resources :costs do
    get 'survey', on: :collection
  end

  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
end
