require 'rails_helper'

RSpec.describe "Api::V1::ItemComments", type: :request do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:comment) { create(:item_comment) }
  let(:content) { '私も使ってます！' }
  describe 'POST /api/v1/item_comments' do
    it 'コメントの投稿ができる' do
      post api_v1_item_comments_path, params: { user_id: user.id , item_id: item.id, content: content }
      expect(response).to have_http_status 204
    end
  end

  describe 'DELETE /api/v1/item_comments' do
    it 'コメントの削除ができる' do
      delete api_v1_item_comment_path(comment.id), params: { user_id: user.id , item_id: item.id}
      expect(response).to have_http_status 204
    end
  end
end
