require 'rails_helper'

RSpec.describe 'Api::V1::Topics', type: :request do
  let(:topic_params) { attributes_for(:topic) }
  let(:user) { create(:user) }
  let(:params) do {
    title: '初めての一人暮らしにおすすめのアイテム',
    description: '初めての一人暮らしを始める人向けに新生活をより便利で快適にするためのおすすめアイテムを教えてください！',
    user_id: user.id
  }
  end

  describe 'POST /api/v1/topics' do
    it 'リクエストが成功すること' do
      expect do
        post api_v1_topics_path, params: { topic: topic_params }
        expect(response).to have_http_status 200
        expect(json['topic']).to eq(topic.id)
      end
      end.to change{ Topic.count }.by(1)
    end
  end

  describe 'GET /api/v1/topics' do
    context 'アイテムが存在する場合' do
      before do
        create_list(:topic, 6)
      end

      it 'リクエストが成功すること' do
        get api_v1_topics_path
        expect(response).to have_http_status 200
      end

      it 'topicが6件取得できていること' do
        get api_v1_topics_path
        expect(json.length).to eq(6)
      end
    end
  end

  describe 'GET /api/v1/topics/:id' do
    context 'アイテムが存在する場合' do
      let!(:topic) { create(:topic) }

      it 'リクエストが成功すること' do
        get api_v1_topics_path(topic.id)
        expect(response).to have_http_status 200
      end

      it 'topicが取得できていること' do
        get api_v1_topics_path(topic.id)
        expect do
          expect(json.length).to eq(1)
          expect(json['topic']).to eq(topic.title)
        end
      end
    end
  end

  describe 'GET /api/v1/topics/:id/fetch' do
    context 'アイテムが存在する場合' do
      let!(:topic) { create(:topic) }

      it 'リクエストが成功すること' do
        get fetch_api_v1_topic_path(topic.id)
        expect(response).to have_http_status 200
      end

      it 'topicが取得できていること' do
        get fetch_api_v1_topic_path(topic.id)
        expect do
          expect(json.length).to eq(1)
          expect(json['topic']).to eq(topic.title)
        end
      end
    end
  end

  describe 'PATCH/PUT /api/v1/topics/:id' do
    let(:topic) { create(:topic) }
    let(:params) do {
      title: 'QOLが上がること間違いなしです！',
      description: 'QOLが上がること間違いなしです！',
    }
    end
    it 'トピックの編集ができる' do
      patch api_v1_topic_path(topic.id), params: { topic: topic_params }
      expect(response).to have_http_status 200
    end
  end

  describe 'DELETE /api/v1/topic' do
    let!(:topic) { create(:topic) }
    it 'リクエストが成功する' do
      expect do
        delete api_v1_topic_path(topic.id)
        expect(response).to have_http_status 204
      end.to change{ Topic.count }.by(-1)
    end
  end
end
