Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 'welcome#index'

 	get 'sessions/destroy'
 	get 'sessions/create'	
	get 'auth/:provider/callback', to: 'sessions#create'
	get 'auth/failure', to: redirect('/')
	get 'signout', to: 'sessions#destroy', as: 'signout'

	resources :sessions, only: [:create, :destroy]
	resource :home, only: [:show]

	resources :users

    resources :products

    namespace :admin do
    	resources :products
	end

end
