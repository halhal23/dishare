module Api
  class InviteConversationsController < ApplicationController
    def create
      conv = InviteConversation.new(conv_params)
      if conv.save
        convs = InviteConversation.where(invitation_id: conv.invitation_id)
        render json: convs
      else
        render json: "error"
      end
    end
    
    def destroy
      conv = InviteConversation.find(params[:id])
      conv.destroy
      convs = InviteConversation.all
      render json: convs
    end

    private

    def conv_params
      params.permit(:message,
                    :user_id,
                    :invitation_id)
    end

  end
end
  