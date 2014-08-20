Rails.application.routes.draw do
  root    'adverts#index'

  get     'admin_job/nonpublished'
  get     'admin_job/manage_advert_type'
  post    'admin_job/approve'
  post    'admin_job/approve_all'
  delete  'admin_job/delete_type'
  put     'admin_job/create_type'
  get     'admin_job/reject_reason'
  put     'admin_job/rejected'

  resources :adverts do
    get 'search', on: :collection
  end

  devise_for :users, :controllers => {:registrations => "registrations"}

  get     'persons/profile'
  get     'persons/index'
  get     'persons/edit'
  get     'persons/new'
  put     'persons/save_changes'
  delete  'persons/delete'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
