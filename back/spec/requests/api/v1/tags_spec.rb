require 'rails_helper'

RSpec.describe "Api::V1::Tags", type: :request do
  let(:tag) { create(:tag) }

  describe "GET /api/v1/tags" do
    before do
      create_list(:tag, 10)
    end

    it "リクエストが成功すること" do
      get api_v1_tags_path
      expect(response).to have_http_status 200
    end

    it 'tagがすべて取得できていること' do
      get api_v1_tags_path
      expect(json.length).to eq(Tag.count)
    end
  end

  describe "GET /api/v1/tags/:id" do
    it "リクエストが成功すること" do
      get api_v1_tags_path(tag.id)
      expect(response).to have_http_status 200
    end
  end
end
