Rails.application.routes.draw do
  root "home#index"
  mount_devise_token_auth_for 'User', at: 'auth'
  scope '/api' do
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
end
