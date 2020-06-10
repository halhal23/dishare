module Api
  class CommentsController < ApplicationController
    def create
      comment = Comment.new(comment_params)
      if comment.save
        post = Post.find(comment.post.id)
        render json: post
      else
        render json: comment
      end
    end

    def destroy
      comment = Comment.find(params[:id])
      if comment.destroy
        post = Post.find(comment.post.id)
        render json: post
      else
        render json: { status: 200 }
      end
    end

    private

    def comment_params
      params.permit(:message, :user_id, :post_id)
    end
  end
end
