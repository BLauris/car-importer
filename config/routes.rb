Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'cars#index'

  resources :cars, only: [:index, :new, :create] do
    get :import_preview, on: :member
    get :import, on: :member

    collection do
      get :new_import
      post :save_csv
      delete :delete_all
    end
  end
end
