module Api
  class CommentsController < ApplicationController
    def create
      comment = Comment.new(comment_params)
      if comment.save
        render json: comment
      else
        render json: comment
      end
    end

    private

    def comment_params
      params.permit(:message, :user_id, :post_id)
    end
  end
end
