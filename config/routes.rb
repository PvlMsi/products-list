Rails.application.routes.draw do
  resources :products
  resources :categories do
    get :parameters, on: :member
  end

  root to: 'home#welcome'
end
