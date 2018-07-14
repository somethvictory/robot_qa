Rails.application.routes.draw do
  root to: 'dashboard#index'

  resources :robots, only: [:index] do
    collection do
      post :recycle
      get :qa_passed
      get :factory_second
    end
    member do
      post :extinguish
    end
  end

  put '/shipments/create'
end
