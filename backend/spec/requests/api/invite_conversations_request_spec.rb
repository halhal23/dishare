require 'rails_helper'

RSpec.describe "Api::InviteConversations", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/api/invite_conversations/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/invite_conversations/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
