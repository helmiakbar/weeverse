Weeverse::Application.routes.draw do
  resources :events

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  get 'tags/:tag', to: 'projects#index', as: :tag
  get 'tags1/:tag', to: 'ideas#index', as: :tag1
  
  resources :socials do 
    collection do 
      get "get_thumbnail"
      post "upload_photo"
    end
  end

  resources :ideas do
    collection do 
      get "idea_show"
      get "idea_region"
      get "idea_city"
    end
  end

  # resources :projects

  resources :projects do 
    collection do
      get "project_show"
      get "project_region"
      get "project_city"
    end
  end
  
  post "share_project" => "projects#share_project"
  get "join/:id" => "projects#join", as: :join
  get "all" => "projects#all"
  get "big/:id" => "projects#big", as: :big
  post "sent_mail" => "projects#sent_mail", as: :sent_mail
  get "user_content" => "projects#user_content"
  post "contact_author" => "socials#contact_author", as: :contact_author

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'projects#index'

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
