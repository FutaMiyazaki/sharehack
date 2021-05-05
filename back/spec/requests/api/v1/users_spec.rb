require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'POST /api/v1/users/' do
    context '正常' do
      before do
        post '/auth/sign_in', params: {email:user['email'], password: 'password'}
        valid_params = { name: 'テストユーザー',
          email: 'test@sharehack.com',
          password: 'password',
          password_confirmation: 'password' }
        end

        example 'HTTPステータスが200であること' do
          expect(response.status).to eq(200)
        end
        example 'データが作成されていること' do
          expect { user '/api/v1/users', params: { user: valid_params } }.to change(User, :count).by(+1)
        end

        example 'レスポンスが正しいこと' do
          json = JSON.parse(response.body)
          expect(json['data']['email']).to eq(user['email'])
        end
      end
    end
  describe 'GET /api/v1/auth/sign_in' do

  end
end
