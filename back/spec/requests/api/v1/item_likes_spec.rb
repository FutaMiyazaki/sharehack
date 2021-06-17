require 'rails_helper'

RSpec.describe 'Api::V1::ItemLikes', type: :request do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  describe 'POST /api/v1/item_likes' do
    it 'アイテムにいいね付与ができる' do
      post api_v1_item_likes_path, params: { user_id: user.id , item_id: item.id }
      expect do
        expect(response).to have_http_status 200
        expect(json.length).to eq(1)
      end
    end
  end

  describe 'DELETE /api/v1/item_likes' do
    it 'アイテムに付与済みいいねの取り消しができる' do
      post api_v1_item_likes_path, params: { user_id: user.id , item_id: item.id }
      delete api_v1_item_likes_path, params: { user_id: user.id , item_id: item.id }
      expect do
        expect(response).to have_http_status 200
      end.to change{ ItemLike.count }.by(0)
    end
  end
end
