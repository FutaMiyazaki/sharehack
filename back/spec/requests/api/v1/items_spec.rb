require 'rails_helper'

RSpec.describe 'Api::V1::Items', type: :request do
  let(:item_params) { attributes_for(:item) }
  let(:user) { create(:user) }
  let(:params) do {
    name: '全自動洗濯機',
    description: '年120時間自由時間が増えます！',
    link: 'https://www.amazon.co.jp/%E3%82%A2%E3',
    price: 100000,
    user_id: user.id
  }
  end

  describe 'POST /api/v1/items' do
    it 'リクエストが成功すること' do
      expect do
        post api_v1_items_path, params: { item: item_params }
        expect(response).to have_http_status 200
        expect(json['item']).to eq(item.id)
      end
      end.to change{ Item.count }.by(1)
    end
  end

  describe 'GET /api/v1/items' do
    context 'アイテムが存在する場合' do
      before do
        create_list(:item, 6)
      end

      it 'リクエストが成功すること' do
        get api_v1_items_path
        expect(response).to have_http_status 200
      end

      it 'アイテムが6件取得できていること' do
        get api_v1_items_path
        expect(json.length).to eq(6)
      end
    end
  end

  describe 'GET /api/v1/items/:id' do
    context 'アイテムが存在する場合' do
      let!(:item) { create(:item) }

      it 'リクエストが成功すること' do
        get api_v1_items_path(item.id)
        expect(response).to have_http_status 200
      end

      it 'アイテムが取得できていること' do
        get api_v1_items_path(item.id)
        expect do
          expect(json.length).to eq(1)
          expect(json['item']).to eq(item.name)
        end
      end
    end
  end

  describe 'PATCH/PUT /api/v1/items/:id' do
    let(:item) { create(:item) }
    let(:params) do {
      description: 'QOLが上がること間違いなしです！',
      price: 150000
    }
    end
    it 'アイテムの編集ができる' do
      patch api_v1_item_path(item.id), params: { item: item_params }
      expect(response).to have_http_status 200
    end
  end

  describe 'DELETE /api/v1/item' do
    let!(:item) { create(:item) }
    it 'リクエストが成功する' do
      expect do
        delete api_v1_item_path(item.id)
        expect(response).to have_http_status 204
      end.to change{ Item.count }.by(-1)
    end
  end
end
