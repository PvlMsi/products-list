Rails.application.routes.draw do
  resources :products
  resources :parameters
  resources :categories do
    get :parameters, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
