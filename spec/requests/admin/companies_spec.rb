require 'rails_helper'

RSpec.describe "Admin::Companies", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/admin/companies/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/admin/companies/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/companies/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/companies/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
