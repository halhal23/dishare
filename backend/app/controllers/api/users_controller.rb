
module Api
  class UsersController < ApplicationController
    def index
    end
  
    def show
      user = User.find(params[:id])
      render json: user
    end
  end
end
