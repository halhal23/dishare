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
        logger.debug "今から保存処理は入ります。"
        photo_params[:picture]&.each do |p|
          logger.debug "保存処理1回目です"
          Photo.create(
            picture: p,
            post_id: post.id
          )
        end 
        logger.debug "保存処理終わりました。"
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
  end
end
