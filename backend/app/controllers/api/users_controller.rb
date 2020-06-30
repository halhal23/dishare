
module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :followings, :followers]

    def index
      users = User.all
      render json: users
    end
  
    def show
      # 投稿、フォロー、フォロワー、送った招待、受けた招待をユーザ情報とともに返す。
      render json: @user, include: [
        # :followings,
        # :followers,
        { followings: [:posts, :followings, :followers]},
        { followers: [:posts, :followings, :followers]},
        { posts: [:user, :photos] },
        { passive_invitations: [:inviter] },
        { active_invitations: [:invited] },
      ]
    end

    def search
      users = User.search(params[:query])
      render json: users
    end

    def get_user_names
      names = User.all.pluck(:name)
      render json: names
    end

    # ログインユーザのフォローユーザーを返す
    def followings
      render json: @user.followings
    end
    # ログインユーザのフォロワーを返す
    def followers
      render json: @user.followers
    end

    private
    def set_user
      @user = User.find(params[:id])
    end
  end
end
