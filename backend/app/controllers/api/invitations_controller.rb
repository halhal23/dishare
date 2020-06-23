module Api
  class InvitationsController < ApplicationController

    def show
      invite = Invitation.find(params[:id])
      render json: invite
    end

    def create
      invite = Invitation.new(invite_params)
      if invite.save
        render json: invite
      else
        render json: "error"
      end
    end

    def update
      invite = Invitation.find(params[:id])
      if invite.update(result_params)
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
                    :shop_latitude,
                    :shop_longitude,
                    :something_to_eat,
                    :invite_date,
                    :comment)
    end

    def result_params
      params.permit(:result)
    end
  end
end