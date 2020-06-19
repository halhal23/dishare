# module Api
#   module Auth
#     class SessionsController < DeviseTokenAuth::SessionsController
      
#       # ログイン後に返される User のjsonデータを Serializerで整形するために上書き 
#       def render_create_success 
#         render json: @resource
#       end 
      
#     end
#   end
# end
