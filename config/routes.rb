OnTheParty::Application.routes.draw do
  match "random-login" => "users#random_login", :as => :random_login

  root :to => 'home#index'

 # get "venues/find_by_id_foursquare"
  resources :events do
    member do
      get 'live_data'
    end
  end
  resources :venues
  namespace :api do
    resources :venues
  #  match '/venues/find_or_create/:id_foursquare/:name/:contact/:address/:latitude/:longitude/:country/:category_id', :controller => 'venues', :action => 'find_or_create', :format => 'json'
  end

  match '/api/venues/find_or_create/:id_foursquare/:name/:contact/:address/:latitude/:longitude/:country/:category_id', :controller => 'api/venues', :action => 'find_or_create', :constraints => {:latitude =>/.*/, :longitude => /.*/}, :format => 'json'
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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
