module Api
  class InvitationsController < ApplicationController

    def create
      invite = Invitation.new(invite_params)
      if invite.save
        render json: invite
      else
        render json: "error"
      end
    end

    private

    def invite_params
      params.permit(:inviter_id,
                    :invited_id,
                    :shop_name,
                    :shop_site_url,
                    :shop_image_url,
                    :shop_address,
                    :something_to_eat,
                    :invite_date,
                    :comment)
    end
  end
end