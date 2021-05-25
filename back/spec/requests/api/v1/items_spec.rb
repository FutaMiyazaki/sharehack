require 'rails_helper'

RSpec.describe 'Api::V1::Items', type: :request do
  describe 'POST /api/v1/items' do
    let(:item_params) { attributes_for(:item) }
    let(:params) do {
      name: '全自動洗濯機',
      description: '年120時間自由時間が増えます！',
      link: 'https://www.amazon.co.jp/%E3%82%A2%E3',
      price: 100000,
      user_id: 1
    }
    end
    it 'アイテムの新規作成ができる' do
      post api_v1_items_path, params: { item: item_params }
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /api/v1/items' do
    let(:item) { create(:item) }
    it '全てのアイテム情報が取得できる' do
      get api_v1_items_path
      expect(response).to have_http_status 200
    end
  end

  describe 'PATCH /api/v1/item' do
    let(:item) { create(:item) }
    let(:item_params) { attributes_for(:item) }
    let(:params) do {
      name: '全自動洗濯機',
      description: '年120時間自由時間が増えます！',
      link: 'https://www.amazon.co.jp/%E3%82%A2%E3',
      price: 120000,
      user_id: 1
    }
    end
    it 'アイテムの編集ができる' do
      patch api_v1_item_path(item.id), params: { item: item_params }
      expect(response).to have_http_status 200
    end
  end

  describe 'DELETE /api/v1/item' do
    let(:item) { create(:item) }
    it 'アイテムの削除ができる' do
      delete api_v1_item_path(item.id)
      expect(response).to have_http_status 204
    end
  end
end
