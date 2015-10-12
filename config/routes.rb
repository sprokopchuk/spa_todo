Rails.application.routes.draw do

  devise_for :users
  root "home#page"
  resources :projects, except: [:show], shallow: true,  defaults: { format: 'json' } do
    resources :tasks, except: [:show] do
      resources :comments, except: [:index, :show] do
        member do
          post "attach_file"
        end
      end
    end
  end
end
