OnTheParty::Application.routes.draw do
  devise_for :users

  match "random-login" => "users#random_login", :as => :random_login

  root :to => 'home#index'

 # get "venues/find_by_id_foursquare"
  resources :events, path: 'eventos' do
    get :live_data, on: :member
  end
  match 'perto-de-voce' => "events#close_to_user", as: :close_to_user
  match 'vai-bombar' => "events#next_events", as: :next_events
  resources :venues
  namespace :api do
    resources :events
    resources :venues do
      post :find_or_create, on: :collection
    end
    resources :users do
      post :find_or_create, on: :collection
    end

    match '/events/create_event/:venue_id/:user_id/:name/:description', :controller => 'events', :action => 'create_event', :format => 'json'
    match '/events/find_actives_by_venue_id/:venue_id/', :controller => 'events', :action => 'find_actives_by_venue_id', :format => 'json'
    # match '/venues/find_or_create/:id_foursquare/:name/:contact/:address/:latitude/:longitude/:country/:category_id', :controller => 'venues', :action => 'find_or_create', :constraints => {:latitude =>/.*/, :longitude => /.*/}, :format => 'json'
  end

#  match '/api/venues/find_or_create/:id_foursquare/:name/:contact/:address/:latitude/:longitude/:country/:category_id', :controller => 'api/venues', :action => 'find_or_create', :constraints => {:latitude =>/.*/, :longitude => /.*/}, :format => 'json'

#  match '/api/events/create_event/:venue_id/:user_id/:name/:description', :contoller => 'api/events', :action => 'create_event', :format => 'json'

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
