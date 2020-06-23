
module Api
  class UsersController < ApplicationController
    def index
      users = User.all
      render json: users
    end
  
    def show
      @user = User.find(params[:id])
      # 投稿、フォロー、フォロワー、送った招待、受けた招待をユーザ情報とともに返す。
      render json: @user, include: [
        :followings,
        :followers,
        { posts: [:user, :photos] },
        { passive_invitations: [:inviter] },
        { active_invitations: [:invited] },
      ]
    end
  end
end
