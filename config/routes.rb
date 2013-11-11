Cybercoach::Application.routes.draw do
  post "/fatsecret", to: "apis#fatsecret"

  get "apis/fatsecret"
  get '/users/:user_id/api_tokens/new' => redirect('/auth/fatsecret?user_id=%{user_id}')
  get '/auth/fatsecret/callback', to: 'api_tokens#create'

  get "api_tokens/create"
  get "welcome/index"
  
  resources :sessions, :only => [:new, :create, :destroy, :index] #FIXME
  resources :sports
  
  resources :users do
   resources :trainings
  end
  
  
  get '/signup',  :to => 'users#new'
  get '/signin',  :to => 'sessions#new'
  #get '/signin', :to => 'sessions#index'
  get '/signout', :to => 'sessions#destroy'  
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
