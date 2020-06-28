Rails.application.routes.draw do
  
  namespace :api do
    get 'invite_conversations/create'
    get 'invite_conversations/destroy'
  end
  # API設計の観点からnamespaceを使用し、 /api/each_api 形式でrouting設定を行う
  namespace :api, format: 'json' do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
    get 'test', to: 'relationships#test'
    get 'isFollowed', to: 'relationships#isFollowed'
    get 'posts/following_posts'
    get 'posts/follower_posts'
    get 'posts/each_posts'
    get 'users/followings'
    get 'users/followers'
    resources :users, only: [:index, :show]
    resources :posts
    resources :comments, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
    resources :invitations, only: [:show, :create, :update, :destroy]
    resources :invite_conversations, only: [:create, :destroy]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
