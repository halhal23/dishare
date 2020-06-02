Rails.application.routes.draw do

  # namespaceを使用し、 /api/each_api 形式でrouting設定を行う
  namespace :api, format: 'json' do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
    get 'users/index'
    get 'users/show', to: 'users#show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
