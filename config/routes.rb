Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#index'
  get 'about', to: 'pages#about'
  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :articles do 
  	resources :comments
  	resources :likes
	end
end
