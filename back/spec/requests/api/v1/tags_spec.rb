require 'rails_helper'

RSpec.describe "Api::V1::Tags", type: :request do
  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/api/v1/tags/index"
  #     expect(response).to have_http_status(:success)
  #   end

  #   context 'タグおよび対象のタグを持つ投稿が存在する場合' do
  #     let(:takashi) { FactoryBot.create :takashi }

  #     it 'リクエストが成功すること' do
  #       get :show, params: { id: takashi }
  #       expect(response.status).to eq 200
  #     end

  #     it 'showテンプレートで表示されること' do
  #       get :show, params: { id: takashi }
  #       expect(response).to render_template :show
  #     end

  #     it '@userが取得できていること' do
  #       get :show, params: { id: takashi }
  #       expect(assigns :user).to eq takashi
  #     end
  #   end

  #   context 'ユーザーが存在しない場合' do
  #     subject { -> { get :show, params: { id: 1 } } }

  #     it { is_expected.to raise_error ActiveRecord::RecordNotFound }
  #   end
  # end
end
