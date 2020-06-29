module Api
  class PostsController < ApplicationController
    before_action :set_user, only: [:follower_posts, :following_posts, :each_posts]
    # フォローしているユーザと自分の post のみを返す
    def index
      posts = Post.all.order(created_at: "DESC")
      render json: posts
    end

    def following_posts
      posts = Post.where(user_id: @user.followings.ids).order(created_at: "DESC")
      render json: posts
    end

    def follower_posts
      posts = Post.where(user_id: @user.followers.ids).order(created_at: "DESC")
      render json: posts
    end
 
    def show
      post = Post.find(params[:id])
      render json: post
    end
  
    def create
      post = Post.new(post_params)
      if post.save
        photo_params[:picture]&.each do |p|
          Photo.create(
            picture: p,
            post_id: post.id
          )
        end 
        render json: post
      else
        render json: post
      end
    end
  
    def destroy
      post = Post.find(params[:id])
      post.destroy
      render json: post
    end

    private
    
    def post_params
      params.permit(:title, 
                    :content, 
                    :shop_name, 
                    :shop_category, 
                    :shop_address, 
                    :shop_access, 
                    :shop_url, 
                    :shop_image_url, 
                    :user_id)
    end

    def photo_params
      params.permit( picture: [])
    end

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
