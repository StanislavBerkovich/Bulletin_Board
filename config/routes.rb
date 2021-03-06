Rails.application.routes.draw do

  scope '(:locale)' do

    root 'adverts#index'

    resources :adverts do
      collection do
        get 'search'
        post 'personal_locale', as: 'locale'
        get 'nonpublished'
        post 'approve_all'
      end

      member do
        post 'approve'
        get 'reject_reason'
        put 'reject'
      end
    end

    resources :types, only: [:index, :create, :destroy]

    devise_for :users, :controllers => {:registrations => "registrations"}

    controller :persons do
      get 'profile'
      get 'index', as:'persons_index'
      get 'edit', as: 'edit_person'
      get 'new', as: 'new_person'
      put 'save_changes'
      delete 'delete', as: 'delete_person'
    end
  end


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
