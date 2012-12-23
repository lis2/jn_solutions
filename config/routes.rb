JnSolutions::Application.routes.draw do
  resources :releases, only: [:index, :create] do
    member do
      get :rebuild
    end
  end
  root :to => 'releases#index'
end
