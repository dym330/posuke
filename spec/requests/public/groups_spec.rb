require 'rails_helper'

RSpec.describe "Public::Groups", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/public/groups/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/public/groups/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/public/groups/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
