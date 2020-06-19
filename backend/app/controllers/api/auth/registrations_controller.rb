# frozen_string_literal: true

module Api
  module Auth
    class RegistrationsController < DeviseTokenAuth::RegistrationsController

      # 新規登録後に返される User のjsonデータを Serializerで整形するために上書き 
      # def render_create_success 
      #   render json: resource_data, serializer: UserSerializer
      # end 
      # def render_update_success 
      #   render json: resource_data, serializer: UserSerializer
      # end 
      
      
      private

      # ストロングパラメーター設定
      def sign_up_params
        params.permit(:name, :email, :password, :password_confirmation, :image)
      end

      def account_update_params
        params.permit(:name, :email, :image)
      end
    end
  end
end