Sportsfriender::Application.routes.draw do
 

  resources :groups


resources :cities
resources :participants
resources :event_posts

devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}


scope '(:locale)' do

root to: 'pages#home'

devise_for :users, controllers: { sessions: 'my_sessions', registrations: 'registrations'}, skip: :omniauth_callbacks

resources :sports
resources :users
resources :ratings
resources :events
resources :locations
resources :groups
resources :meassages
resources :contacts, only: [:new, :create]
resources :assessments, only: [:edit, :update]

match "/auth/:provider/callback" => "sessions#create"
match "/auth/failure", :to => "sessions#failure"
match '/welcome',   :to => 'pages#welcome'
match '/newsport',   :to => 'ratings#new'
match '/map', :to => 'locations#map'
match '/dashboard', :to => 'pages#dashboard'
match '/myevents', :to => 'pages#myevents'
match '/feedback', :to => 'pages#feedback'
match '/search', :to => 'events#search'
match '/searchfriends', :to => 'userss#search'
match '/mysports', :to => 'pages#mysports'
match '/myprogress', :to => 'pages#myprogress'
match '/mysportsfriends', :to => 'pages#mysportsfriends'
match '/pointer' , :to => 'pages#pointer'
match '/terms' , :to => 'pages#terms'
match '/privacy' , :to => 'pages#privacy'
match '/newmessage' , :to => 'messages#new'
match '/about' , :to => 'pages#about'
match '/contact',     to: 'contacts#new'

#For email testing
if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/devel/emails"
end

end

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
  # match ':controller(/:action(/:id))(.:format)'
end
