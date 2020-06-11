module Api
  class RelationshipsController < ApplicationController
    before_action :set_user

    def create
      following = current_user.follow(@user)
      if following.save
        render json: @user
      else
        render json: { status: 400 }
      end
    end
  
    def destroy
      following = current_user.unfollow(@user)
      if following.destroy
        render json: @user
      else
        render json: { status: 400 }
      end
    end

    def test
      render json: { msg: "ok test pass"}
    end
  
    private
    def
      @user = User.find(params[:follow_id])
    end
  end
end
