require 'rails_helper'

RSpec.describe "Public::Schedules", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/public/schedules/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/public/schedules/show"
      expect(response).to have_http_status(:success)
    end
  end

end
