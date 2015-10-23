Rails.application.routes.draw do

  # get '/password_resets/new' => 'password_resets#new'
  # post '/password_resets' => 'password_resets#create'
  # get '/password_resets/:id/edit' => 'password_resets#edit'
  # get '/password_reset' => 'password_reset'

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :users
  resources :songs
  resources :performances
  resources :password_resets, only: [:new, :create, :edit, :update]
  get '/login' => 'sessions#login'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/welcome' => 'welcome#index'
  post '/songs/search' => 'songs#search'
  post '/songs/simple_search' => 'songs#simple_search'

  get '/performances/:performance_id/add_song/:song_id' => 'performances#add_song_to_performance'

  delete '/performances/:performance_id/songs/:song_id/delete' => 'performances#delete_song_from_performance'

  get '/users/change_password/:id' => 'users#change_password'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


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
