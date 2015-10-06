Rails.application.routes.draw do

  devise_for :users
  root "projects#index"
  resources :projects, except: [:show], defaults: { format: 'json' } do
    resources :tasks, except: [:show], defaults: { format: 'json' } do
      resources :comments, except: [:index], defaults: { format: 'json' }
    end
  end
end
