
module Api
  class UsersController < ApplicationController
    def index
      users = User.all
      render json: users
    end
  
    def show
      user = User.find(params[:id])
      render json: user
    end
  end
end

# render json: [@posts.to_json(:include => [:comments, :images]), [user: @user.to_json]]
