Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/oauth2_callbacks" }

  # You can have the root of your site routed with "root"
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
