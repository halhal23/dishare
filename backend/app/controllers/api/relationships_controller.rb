module Api
  class RelationshipsController < ApplicationController
    before_action :set_user, except: [:test]

    def create
      following = @current_user.follow(@user)
      if following.save
        render json: @user
      else
        render json: { status: 400 }
      end
    end
  
    def destroy
      following = @current_user.unfollow(@user)
      if following.destroy
        render json: @user
      else
        render json: { status: 400 }
      end
    end

    def test
      current_user = User.find(params[:user_id])
      render json: { msg: "ok test pass", current_user: current_user}
    end

    # ログインユーザーが指定したユーザーをフォローしているかの真偽値を返す。
    def isFollowed
      isFollowed = @current_user.following?(@user)
      render json: isFollowed
    end
  
    private
    def set_user
      @current_user = User.find(params[:user_id])
      @user = User.find(params[:follow_id])
    end
  end
end
