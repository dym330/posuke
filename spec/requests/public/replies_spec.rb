require 'rails_helper'

RSpec.describe "Public::Replies", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/public/replies/index"
      expect(response).to have_http_status(:success)
    end
  end

end
