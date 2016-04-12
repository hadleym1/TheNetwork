Rails.application.routes.draw do
  get 'show_user/index'
  post 'show_user/index' => 'show_user#become_fan'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'active_user/home'
  post 'active_user/home' => 'active_user#create'
  post 'active_user/load_updates' => 'active_user#load_updates'

  post 'active_user/send_fan_message' => 'active_user#send_fan_message'
  post 'active_user/ask_fan_question' => 'active_user#ask_fan_question'
  post 'active_user/accept_fan' => 'active_user#accept_fan'
  post 'active_user/show_hide_requests' => 'active_user#show_hide_requests'
  post 'active_user/show_hide_responses' => 'active_user#show_hide_responses'
  post 'active_user/respond_to_question' => 'active_user#respond_to_question'
  post 'active_user/respond_to_fan' => 'active_user#respond_to_fan'
  post 'active_user/poll_fans' => 'active_user#poll_fans'
  post 'active_user/submit_fan_vote' => 'active_user#submit_fan_vote'
  post 'active_user/fan_vote' => 'active_user#fan_vote'
  post 'active_user/show_hide_results' => 'active_user#show_hide_results'

  post 'chat/index' => 'chat#index'
  post 'chat/update' => 'chat#update'
  
  post 'active_user/delete_fan'

  get 'chat/update'
  get 'chat/index'

  resources :users
  get 'say/hello'
  post 'say/login' => 'say#login'
  post 'say/signup' => 'say#signup' 

  post 'active_user/logout' => 'active_user#logout'

  get 'say/goodbye'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
