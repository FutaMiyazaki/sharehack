require 'rails_helper'

RSpec.describe "Topics", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/topics/create"
      expect(response).to have_http_status(:success)
    end
  end

end
