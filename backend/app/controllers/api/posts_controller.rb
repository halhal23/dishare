module Api
  class PostsController < ApplicationController
    def index
      posts = Post.all
      render json: posts
    end
  
    def show
      post = Post.find(params[:id])
      render json: post
    end
  
    def create
      post = Post.new(post_params)
      if post.save
        render json: post
      else
        render json: post
      end
    end
  
    def delete
    end

    private
    
    def post_params
      params.permit(:title, :content, :shop_name, :shop_category, :shop_address, :shop_access, :shop_url, :shop_image_url, :user_id)
    end
  end
end
