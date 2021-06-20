require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  describe 'POST /api/v1/relationships' do
    it 'フォローができる' do
      post api_v1_relationships_path, params: { user_id: user.id , follow_id: other_user.id, uid: user.email }
      expect do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'DELETE /api/v1/relationship/:id' do
    it 'フォローの取り消しができる' do
      post api_v1_relationships_path, params: { user_id: user.id , follow_id: other_user.id, uid: user.email }
      delete api_v1_relationship_path(user.id), params: { user_id: user.id , follow_id: other_user.id, uid: user.email }
      expect do
        expect(response).to have_http_status 200
      end.to change{ Relationship.count }.by(0)
    end
  end
end
