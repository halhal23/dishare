
module Api
  class UsersController < ApplicationController
    def index
    end
  
    def show
      user = User.find(params[:user_id])
      render json: user
    end
  end
end
