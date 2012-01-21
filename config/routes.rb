Versioneye::Application.routes.draw do
  
  root :to => "products#index"

  resources :products
  match '/search',            :to => 'products#search'
  match '/follow',            :to => 'products#follow'
  match '/unfollow',          :to => 'products#unfollow'
  match '/product/:id',       :to => 'products#show'
  match '/product/:id/version/:version', :to => 'products#show'
  
  resources :users,           :key => :username
  match '/signup',            :to => 'users#new'
  match '/users/:id/updatenames',    :to => 'users#updatenames'
  match '/users/:id/updatepassword', :to => 'users#updatepassword'
  match '/users/activate/:verification', :to => 'users#activate'
  match '/iforgotmypassword', :to => 'users#iforgotmypassword'
  match '/resetpassword',     :to => 'users#resetpassword'
  match '/home',              :to => 'users#home'

  resources :versioncomments
  
  resources :sessions,        :only => [:new, :create, :destroy]
  match '/signin',            :to => 'sessions#new'
  match '/signout',           :to => 'sessions#destroy'
  
  resources :crawles
  match '/crawles',           :to => 'crawles#index'  
    
  match '/about',             :to => 'page#about'
  match '/impressum',         :to => 'page#impressum'
  match '/imprint',           :to => 'page#imprint'
  match '/terms',             :to => 'page#terms'
  match '/facebook/callback', :to => 'facebook#callback'
  match '/twitter/callback',  :to => 'twitter#callback'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
