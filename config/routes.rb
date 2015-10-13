Rails.application.routes.draw do
  root 'static_pages#home'

  namespace :api, constraints: { format: 'json' } do
    resources :spaces, only: [] do
      collection do
        get 'search'
      end
    end
  end
end
